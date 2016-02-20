class Users::FavoriteCoursesController < ApplicationController
  include CourseManager

  before_action :authenticate_user!
  before_action :job_state, only: :export

  def show
    @entries = Entry.where(code: current_user.favorite_courses).includes(:course)
  end

  def create
    if Entry.where(code: params[:favorite_course].to_s).empty?
      return redirect_to({ action: :show }, alert: '課程不存在')
    end

    append_course(:favorite_courses, params[:favorite_course])
  end

  def destroy
    delete_course(:favorite_courses, params[:favorite_course])
  end

  def export
    return redirect_to(action: :show) unless validate_input
    
    BookmarkingCoursesJob.perform_later(current_user, params[:password])
    redirect_to action: :show
  end

  private

  def validate_input
    alert = []
    alert << '非學生帳號' unless current_user.student?
    alert << '追蹤清單是空的' if current_user.favorite_courses.empty?
    alert << '密碼空白' if params[:password].blank?
    alert << '工作尚未結束' if @queued

    return true if alert.empty?

    flash[:alert] = alert.join(', ')
    false
  end

  def job_state
    @queued = Rails.cache.fetch("course_export_status_#{current_user.id}")
  end
end
