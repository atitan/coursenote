namespace :data do
  desc "import data from url to database"
  task :import , [:yearterm] => :environment do |_task, args|
    unless args.yearterm
      raise "No yearterm specified...aborting"
    end

    # read status file
    fingerprint_file = Rails.root.join('lib/tasks/data.fingerprint')
    if File.exist?(fingerprint_file)
      fingerprint = Marshal.load(File.read(fingerprint_file))
    else
      fingerprint = ""
    end

    # pass yearterm using this sort of command `rake data:import[1031]`
    require 'net/http'
    print 'Downloading...'
    uri = URI('https://itouch.cycu.edu.tw/active_system/CourseQuerySystem/GetCourses.jsp?yearTerm=' + args.yearterm)
    raw = Net::HTTP.get_response(uri).body.force_encoding("utf-8")
    raw.gsub!(/(\s+|\r|\n)/, '') # remove space or newline
    puts 'completed'

    if raw.empty?
      raise 'Empty response from server'
    end

    # check content hash
    require 'digest'
    raw_digest = Digest::SHA1.hexdigest(raw)
    if fingerprint == raw_digest
      raise 'Nothing new to update'
    else
      fingerprint = raw_digest
    end

    print 'Processing...'
    raw[0..1] = '' # remove '@@' from head of string
    data = raw.split('@@')

    # reject empty dataset
    if data.include?('')
      raise "\nEmpty dataset detected...aborting"
    end

    data.map!{ |x| x.split('|') }

    # check if column differs
    if data[0].size != 38
      raise "\nColumn size incorrect...aborting"
    end

    entries = []
    courses = data.collect do |x|
      entries << {
        code: x[6], # 代號
        timetable: Entry.time_str_to_table([x[16], x[18], x[20]]), # 時間表
        timestring: concat_timestring(x[16], x[18], x[20]), # 字串時間表
        cross_graduate: !x[1].empty?, # 跨部
        cross_department: !x[2].empty?, # 跨系
        department: x[9], # 開課系級
        credit: x[14].to_i, # 學分
        required: x[11].include?('必'), # 必選修
        quittable: x[4].empty?, # 是否可停修
        note: x[22], # 備註
        capacity: x[37] # 選課餘額(總額)
      }

      {
        category: x[7], # 類別
        title: x[10], # 課程名稱
        instructor: x[15], # 講師
        #available: true
      }
    end
    puts 'completed'

    print "Importing..."
    ActiveRecord::Base.transaction do
      # before start updating record, wipe out all course entries
      # and reset course status to unavailable
      Entry.destroy_all
      Course.update_all(available: false)

      # start updating
      total = courses.length
      percentage = 0
      courses.each_with_index do |course, index|

        course_record = Course.find_or_initialize_by(course)
        course_record.save!
        course_record.update_attributes(available: true)
        course_record.entries.create(entries[index])

        current_percentage = (index * 100 / total)
        if current_percentage > percentage
          percentage = current_percentage
          print "\rImporting...#{percentage}% completed"
        end
      end

      # sync users' course list
      print "\rImporting...100% completed\nSyncing user data..."
      users = User.where("favorite_courses <> '{}'")
      users.each do |user|
        entries = Entry.where(code: user.favorite_courses)
        if user.favorite_courses.size != entries.size
          user.update(favorite_courses: entries.map{|x| x.code })
        end
      end
    end
    File.write(fingerprint_file, Marshal.dump(fingerprint))
    puts 'completed'
    puts 'Done!'    
  end

  task :build_sitemap => :environment do |_task, _args|
    puts 'Generating sitemap...'

    courses = Course.select(:id)

    require 'builder'
    builder = Builder::XmlMarkup.new(indent: 2)
    builder.instruct!

    xml = builder.urlset('xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
      courses.each do |course|
        builder.url do
          builder.loc(Rails.application.routes.url_helpers.course_url(course.id, host: 'https://coursewiki.clouder.today'))
        end
      end
    end

    File.open(Rails.root.join('public/sitemap.xml'), 'w') do |f|
      f << xml
    end

    puts 'Done!'
  end

  def concat_timestring(*time)
    time.delete_if {|t| t.blank? }
    time.join(', ')
  end
end
