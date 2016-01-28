module Users::TimeFilterHelper
  def timetable_to_string(timetable)
    timetable.map{|k,v| "#{k}-#{v.join('')}"}.join(', ')
  end
end
