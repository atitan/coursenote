module ApplicationHelper
  def display_flash!
    buffer = ''
    flash.each do |key, value|
      buffer << render_flash(key, value)
    end
    raw buffer
  end

  def render_flash(key, value, dismissable = true)
    case key.to_s
    when 'alert', 'error'
      type = 'danger'
    when 'warning'
      type = 'warning'
    when 'notice'
      type = 'info'
    when 'success'
      type = 'success'
    end

    render partial: 'common/flash', locals: { type: type, message: value, dismissable: dismissable }
  end

  def vote_status(object, btn_type)
    return '' if @votes.nil? || @votes == []

    found = @votes.find do |vote|
      vote[:votable_type] == object.class.name && vote[:votable_id] == object.id
    end

    if found.nil? || found.upvote != btn_type
      ''
    else
      'vote-actived pure-disabled'
    end
  end

  def fav_course_status(code)
    return '' if current_user.nil? || current_user.favorite_courses == []

    found = current_user.favorite_courses.find do |entry|
      entry == code
    end

    if found.nil?
      ''
    else
      'follow-actived pure-disabled'
    end
  end

  def tab_li(text, url, icon)
    active = :active if request.path == url
    content_tag :li, class: 'tab-item h4' do
      link_to url, class: active do
        content_tag(:span, text, class: 'hidden-xs') +
          content_tag(:i, '', class: "fa #{icon}")
      end
    end
  end

  def concat_title(base_title, add_title, reverse = false)
    if reverse
      base_title + ' - ' + add_title
    else
      add_title + ' - ' + base_title
    end
  end

  def time_overlap?(timetable, current_user)
    return '' if current_user.nil?

    time_filter = current_user.time_filter
    nonoverlap = time_filter.empty?

    nonoverlap ||= timetable.keys.all? do |key|
      time_filter.key?(key) && (timetable[key] - time_filter[key]).empty?
    end

    nonoverlap ? '' : 'background-color: #FFD4D4'
  end
end
