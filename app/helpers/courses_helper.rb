module CoursesHelper
  def time_overlap?(timetable, time_filter)
    return '' if time_filter.empty? or time_filter.merge(timetable) == time_filter
    'background-color: #FFCCCC'
  end
end
