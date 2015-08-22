namespace :data do
  desc "import data from url to database"
  task :import , [:yearterm] => :environment do |task, args|
    require 'net/http'

    # pass yearterm using this sort of command `rake data:import[1031]`
    uri = URI('http://itouch.cycu.edu.tw/active_system/CourseQuerySystem/GetCourses.jsp?yearTerm=' + args.yearterm)
    raw = Net::HTTP.get_response(uri).body.force_encoding("utf-8")
    raw.gsub!(/(\s+|\r|\n)/, '') # remove space or newline
    raw[0] = '' # remove first char '@'

    data = raw.split('@')
    data.map!{ |x| x.split('|') }
    data.delete_if{ |x| x.empty? }

    entries = []
    courses = data.collect do |x|
      entries << {
        code: x[6], # 代號
        timetable: convert2timetable([x[16], x[18], x[20]]), # 時間表
        timestring: "#{x[16]} #{x[18]} #{x[20]}", # 字串時間表
        cross_graduate: !x[1].empty?, # 跨部
        cross_department: !x[2].empty?, # 跨系
        department: x[9], # 開課系級
        credit: x[14].to_i, # 學分
        required: x[11].include?('必') ? true : false, # 必選修
        quittable: x[4].empty? ? true : false, # 是否可停修
        note: x[22] # 備註
      }

      {
        category: x[7], # 類別
        title: x[10], # 課程名稱
        instructor: x[15], # 講師
        #available: true
      }
    end

    # before start updating record, wipe out all course entries
    # and reset course status to unavailable
    Entry.destroy_all
    Course.update_all(available: false)

    # start updating
    total = courses.length
    percentage = 0
    print "Importing..."
    @output_errors  = []
    courses.each_with_index do |course, index|

      @record = {}
      @record[:errors] = []

      course_record = Course.find_or_initialize_by(course)
      if course_record.save
        course_record.update_attributes(available: true)
        course_record.entries.create(entries[index])
      else
        course_record.errors.full_messages.each do |message|
          @record[:errors] << message
        end
      end

      unless @record[:errors] == []
        @record.merge!(course)
        @record[:entries] = []
        @record[:entries] << entries[index]
        @output_errors.push(@record)
      end

      current_percentage = (index * 100 / total)
      if current_percentage > percentage
        percentage = current_percentage
        print "\rImporting...#{percentage}% completed"
      end
    end
    puts "\rImporting...done!"
    unless @output_errors == []
      puts '正在產生例外報告...'
      output_file = File.new("lib/tasks/exceptions-#{Time.now.utc.iso8601}.json", 'w')
      output_file.print(JSON.pretty_generate(@output_errors))
    end
  end

  def convert2timetable(time)
    offset = %w(A 1 2 3 4 B 5 6 7 8 C D E F G H)
    output = ''.rjust(112, "0")

    time.each do |x|
      tmp = /(\d)-(\w+)/.match(x)
      next if tmp.nil?

      day = tmp[1].to_i - 1
      sec = tmp[2].split('')
      sec.each do |z|
        output[day*16 + offset.index(z)] = '1'
      end
    end
    output
  end
end
