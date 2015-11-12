module CoursesHelper
  def time_overlap?(timetable, current_user)
    return '' if current_user.nil?
    time_filter = current_user.time_filter
    nonoverlap = time_filter.empty? || timetable.keys.all?{|key| time_filter.has_key?(key) && (timetable[key] - time_filter[key]).empty?}
    nonoverlap ? '' : 'background-color: #FFCCCC'
  end

  def category_button(name)
    active = params[:by_category].include?(name) unless params[:by_category].nil?
    name2 = name.length == 1 ? name + '學' : name
    if active
      '<label class="btn btn-warning mg-b-10 active"><input type="checkbox" name="by_category[]" value="'+ name +'" checked>'+ name2 +'</label>'
    else
      '<label class="btn btn-warning mg-b-10"><input type="checkbox" name="by_category[]" value="'+ name +'">'+ name2 +'</label>'
    end
  end

  def course_status(state)
      if state
        '是'
      else
        '否'
      end
    end
end
