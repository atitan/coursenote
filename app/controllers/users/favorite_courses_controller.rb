class Users::FavoriteCoursesController < ApplicationController
  include CourseManager

  before_action :authenticate_user!
  before_action :job_state, only: :export

  def show
    @entries = Entry.where(code: current_user.favorite_courses).includes(:course)
  end

  def create
    return redirect_to({action: :show}, alert: '課程不存在') if Entry.where(code: params[:favorite_course].to_s).empty?

    append_course(:favorite_courses, params[:favorite_course])
  end

  def destroy
    delete_course(:favorite_courses, params[:favorite_course])
  end

  def export
    alert = []
    alert << '非學生帳號' unless current_user.student?
    alert << '追蹤清單是空的' if current_user.favorite_courses.empty?
    alert << '密碼空白' if params[:password].blank?
    alert << '工作尚未結束' if @queued
    return redirect_to({action: :show}, alert: alert.join(', ')) unless alert.empty?

    BookmarkingCoursesJob.perform_later(current_user, params[:password])
    redirect_to action: :show
  end

  private

  def job_state
    @queued = Rails.cache.fetch("course_export_status_#{current_user.id}")
  end
end
