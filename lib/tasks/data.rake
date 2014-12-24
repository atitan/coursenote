namespace :data do
  desc "import data from files to database"
  task :import => :environment do
	path = ARGV.last
    file = File.open("/Users/ati/Projects/courses.data.html").read
	data = file.split("@")
	data.map!{ |x| x.split("|") }
	data.each{ |x| x[15].gsub!(/\s+/, "") } # remove space from instructor

	# create departments
	depts = data.collect { |x| x[8] }.uniq.reject! { |x| x.empty? if x.is_a? String }
	Department.create( depts.map{ |x| {name: x} } )

	# create categories
	cats = data.collect { |x| x[7] }.uniq
	CourseCategory.create( cats.map{ |x| {name: x} } )

	# create instructors
	ins = data.collect{ |x| x[15] }.uniq
	Teacher.create( ins.map{ |x| { name: x } } )

  end
end
