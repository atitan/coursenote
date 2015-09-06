module CoursesHelper
  def time_overlap?(timetable, time_filter)
    nonoverlap = time_filter.empty? || timetable.keys.all?{|key| time_filter.has_key?(key) && (timetable[key] - time_filter[key]).empty?}
    nonoverlap ? '' : 'background-color: #FFCCCC'
  end
end
