class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :flash_write_back, if: :user_signed_in?
  before_filter :set_paper_trail_whodunnit

  protected

  def flash_write_back
    cache_key = "user_flash_#{current_user.id}"
    cache = Rails.cache.fetch(cache_key)
    return if cache.nil?

    cache.each do |k, v|
      flash[k] = v
    end
    Rails.cache.delete(cache_key)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:password, :password_confirmation, :current_password)
    end
  end
end
