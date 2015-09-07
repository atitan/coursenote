module CoursesHelper
  def time_overlap?(timetable, current_user)
    return '' if current_user.nil?
    time_filter = current_user.time_filter
    nonoverlap = time_filter.empty? || timetable.keys.all?{|key| time_filter.has_key?(key) && (timetable[key] - time_filter[key]).empty?}
    nonoverlap ? '' : 'background-color: #FFCCCC'
  end
end
