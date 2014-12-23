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

end
