module ApplicationHelper

  def display_flash!
    buffer = ""
    flash.each do |key, value|
      buffer << render_flash(key, value)
    end
    raw buffer
  end

  def render_flash(key, value)

      case key.to_s
      when "alert", "error"
        type = "danger"
      when "warning"
        type = "warning"
      when "notice"
        type = "info"
      when "success"
        type = "success"
      else
        type = "asd"
      end

      render partial: 'common/flash', locals: {type: type, message: value}
  end

  def vote_status(object, btn_type)
    return '' if @votes.nil? || @votes.empty?

    found = @votes.find do |vote|
      vote[:votable_type] == object.class.name && vote[:votable_id] == object.id
    end

    if found.nil? || found.upvote != btn_type
      ''
    else
      'vote-actived pure-disabled'
    end
  end

end
