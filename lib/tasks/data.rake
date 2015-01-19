namespace :data do
  desc "import data from url to database"
  task :import => :environment do
    require 'net/http'

    yearterm = '1032'

    uri = URI('http://itouch.cycu.edu.tw/active_system/CourseQuerySystem/GetCourses.jsp?yearTerm=' + yearterm)
    raw = Net::HTTP.get_response(uri).body.force_encoding("utf-8")
    raw.gsub!(/(\s+|\r|\n)/, "") # remove space or newline
    raw[0] = '' # remove first char '@'

    data = raw.split("@")
    data.map!{ |x| x.split("|") }

    entry = []
    course = data.collect do |x|
      entry << {course_code: x[6], timetable: convert2timetable([x[16], x[18], x[20]])}
      {
        cross_graduate: !x[1].empty?, # 跨部
        cross_department: !x[2].empty?, # 跨系
        quittable: x[4].empty? ? true : false, # 是否可停修
        category: x[7], # 類別
        department: x[9], # 開課系級
        title: x[10], # 課程名稱
        required: x[11].include?("必") ? true : false, # 必選修
        credit: x[14].to_i, # 學分
        instructor: x[15], # 講師
        note: x[22] # 備註
      }
    end

    course.each_with_index do |x, i|
      c = Course.find_by(x.select {|k,v| ["category", "department", "title", "instructor"].include?(k) })
      if c.nil?
        Course.create(x) do |u|
          u.terms.new(term: yearterm.to_i)
          u.course_entries.new(entry[i])
        end
      else
        c.update(x)
        c.terms.create(term: yearterm.to_i)
        c.course_entries.create(entry[i])
      end
    end


  end

  desc "re-compute rank for courses and comments"
  task :compute_rank => :environment do

  end

  def convert2timetable(time)
    offset = %w(A 1 2 3 4 B 5 6 7 8 C D E F G)
    output = ""
    (1..90).each {|i| output << "0"}
    time.each do |x|
      tmp = /(\d)-(\w+)/.match(x)
      next if tmp.nil?

      day = tmp[1].to_i - 1
      sec = tmp[2].split("")
      sec.each do |z|
        output[day*15 + offset.index(z)] = "1"
      end
    end
    output.to_s(2)
  end
end
