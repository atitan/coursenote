namespace :data do
  desc "import data from files to database"
  task :import => :environment do
  require 'net/http'

  uri = URI('http://itouch.cycu.edu.tw/active_system/CourseQuerySystem/GetCourses.jsp?yearTerm=1032')
  raw = Net::HTTP.get_response(uri).body.force_encoding("utf-8")
  raw.gsub!(/(\s+|\r|\n)/, "") # remove space or newline
  raw[0] = '' # remove first char '@'

	course = raw.split("@")
	course.map!{ |x| x.split("|") }

  

	depts = data.collect { |x| x[8] }.uniq.reject! { |x| x.empty? if x.is_a? String }
	Department.create( depts.map{ |x| {name: x} } )

  end
end
