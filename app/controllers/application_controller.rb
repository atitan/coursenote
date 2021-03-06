class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :flash_write_back, if: :user_signed_in?
  before_action :set_paper_trail_whodunnit
  before_action :fetch_last_update_time

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

  def fetch_last_update_time
    entry = Entry.last
    if entry.nil?
      @last_entry = DateTime.strptime('0','%s')
    else
      @last_entry = entry.created_at
    end
  end
end
