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
      entry << {
        code: x[6], # 代號
        timetable: convert2timetable([x[16], x[18], x[20]]), # 時間表
        cross_graduate: !x[1].empty?, # 跨部
        cross_department: !x[2].empty?, # 跨系
        note: x[22] # 備註
      }

      {
        quittable: x[4].empty? ? true : false, # 是否可停修
        category: x[7], # 類別
        department: x[9], # 開課系級
        title: x[10], # 課程名稱
        required: x[11].include?("必") ? true : false, # 必選修
        credit: x[14].to_i, # 學分
        instructor: x[15], # 講師
        available: true
      }
    end

    course.each_with_index do |item, index|
      w = Course.where(item.select {|k,v| [:category, :department, :title, :instructor].include?(k) })
      if w.empty?
        w = Course.create(item)
        w.terms.create({term: yearterm.to_i})
        w.entries.create(entry[index])
      elsif !w.empty? && w.count == 1
        w = w.first
        w.update(item)
        w.terms.create({term: yearterm.to_i}) unless w.terms.find_by(term: yearterm.to_i)
        if e = Entry.find_by(code: entry[index][:code])
          e.update(entry[index])
        else
          w.entries.create(entry[index])
        end
      else
        File.open("import_error.txt", 'a') {|file| file.puts entry[index][:code] }
      end
    end


  end

  desc "re-compute rank for courses and comments"
  task :compute_rank => :environment do

  end

  def convert2timetable(time)
    offset = %w(A 1 2 3 4 B 5 6 7 8 C D E F G H)
    output = ""
    (1..112).each {|i| output << "0"}
    time.each do |x|
      tmp = /(\d)-(\w+)/.match(x)
      next if tmp.nil?

      day = tmp[1].to_i - 1
      sec = tmp[2].split("")
      sec.each do |z|
        output[day*16 + offset.index(z)] = "1"
      end
    end
    output
  end
end
