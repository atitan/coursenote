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

    course = data.collect do |x|
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

    Course.create(course.uniq)
    course.uniq.each do |x|

    end


  end
end
