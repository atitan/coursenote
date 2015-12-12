namespace :data do
  desc "import data from url to database"
  task :import , [:yearterm] => :environment do |_task, args|
    require 'net/http'

    # pass yearterm using this sort of command `rake data:import[1031]`
    print 'Downloading...'
    uri = URI('https://itouch.cycu.edu.tw/active_system/CourseQuerySystem/GetCourses.jsp?yearTerm=' + args.yearterm)
    raw = Net::HTTP.get_response(uri).body.force_encoding("utf-8")
    puts "completed"

    print 'Processing...'
    raw.gsub!(/(\s+|\r|\n)/, '') # remove space or newline
    raw[0..1] = '' # remove '@@' from head of string
    data = raw.split('@@')

    # abort task if contains empty dataset
    if data.include?('')
      puts "\nEmpty dataset detected...aborting"
      next
    end

    data.map!{ |x| x.split('|') }

    entries = []
    courses = data.collect do |x|
      entries << {
        code: x[6], # 代號
        timetable: convert2timetable([x[16], x[18], x[20]]), # 時間表
        timestring: "#{x[16]} #{x[18]} #{x[20]}".strip, # 字串時間表
        cross_graduate: !x[1].empty?, # 跨部
        cross_department: !x[2].empty?, # 跨系
        department: x[9], # 開課系級
        credit: x[14].to_i, # 學分
        required: x[11].include?('必'), # 必選修
        quittable: x[4].empty?, # 是否可停修
        note: x[22] # 備註
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
    end
    puts "\n\rDone!"
  end

  def convert2timetable(time)
    output = {}

    time.each do |x|
      tmp = /(\d)-(\w+)/.match(x)
      next if tmp.nil?

      day = tmp[1].to_i
      sec = tmp[2].split('')
      output[day] = sec
    end
    
    output
  end
end
