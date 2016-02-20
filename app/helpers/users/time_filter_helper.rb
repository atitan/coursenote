module Users::TimeFilterHelper
  def timetable_to_string(timetable)
    output = timetable.map{|k,v| "#{k}-#{v.join('')}"}.join('<br>').html_safe
    output.blank? ? '空的' : output
  end
end
