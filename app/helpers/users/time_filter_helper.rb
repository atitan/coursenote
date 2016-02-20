module Users::TimeFilterHelper
  def timetable_to_string(timetable)
    output = timetable.map{ |k,v| "#{k}-#{v.join('')}" }
    output.blank? ? '空的' : output.join('<br>').html_safe
  end
end
