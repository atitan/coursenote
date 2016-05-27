module CoursesHelper
  def category_button(name)
    uri = params[:by_category]
    if !uri.nil? && uri.include?(name)
      active = true
    end
    full_name = name.length == 1 ? "#{name}學" : name

    html = <<-HTML
      <label class="btn btn-warning mg-b-10 #{'active' if active}">
      <input type="checkbox" name="by_category[]" value="#{name}" #{'checked' if active}>
      #{full_name}
      </label>
    HTML

    html.html_safe
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
    state ? '是' : '否'
  end

  def is_author?(obj)
    if user_signed_in? && obj.user_id == current_user.id
      true
    else
      false
    end
  end
end
