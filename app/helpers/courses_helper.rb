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

  def avatar_path(comment)
    gravatar = "https://secure.gravatar.com/avatar/#{comment.avatar}?d=identicon&s=40"
    return gravatar unless user_signed_in?

    if comment.user_id == current_user.id
      'user-indicator.png'
    else
      gravatar
    end
  end

  def page_to_title(page)
    "第#{page}頁"
  end

  def course_status(state)
    if state
        '是'
    else
        '否'
    end
  end
end
