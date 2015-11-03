module CoursesHelper
  def time_overlap?(timetable, current_user)
    return '' if current_user.nil?
    time_filter = current_user.time_filter
    nonoverlap = time_filter.empty? || timetable.keys.all?{|key| time_filter.has_key?(key) && (timetable[key] - time_filter[key]).empty?}
    nonoverlap ? '' : 'background-color: #FFCCCC'
  end

  def category_button(name)
    active = params[:by_category].include?(name) unless params[:by_category].nil?
    if active
      '<label class="btn btn-warning mg-b-10 active"><input type="checkbox" name="by_category[]" value="'+ name +'" checked>'+ name +'</label>'
    else
      '<label class="btn btn-warning mg-b-10"><input type="checkbox" name="by_category[]" value="'+ name +'">'+ name +'</label>'
    end
  end
end
