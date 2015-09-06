module CoursesHelper
  def time_overlap?(entry, current_user)
    time_filter = current_user.time_filter
    return '' if time_filter.empty? or time_filter.merge(entry.timetable) == time_filter
    'background-color: #FFCCCC'
  end
end
