class Users::FavoriteCoursesController < ApplicationController
  include UserDataManager
  include JobSupervisor

  before_action :authenticate_user!
  before_action :job_state, only: :export

  def show
    @entries = Entry.where(code: current_user.favorite_courses).includes(:course)
  end

  def create
    userdata_append(:favorite_courses, params[:favorite_course]) do
      if Entry.where(code: params[:favorite_course].to_s).empty?
        flash[:alert] = '課程不存在'
        next false
      end

      true
    end

    redirect_to action: :show
  end

  def destroy
    userdata_delete(:favorite_courses, params[:favorite_course])
    
    redirect_to action: :show
  end

  def export
    delegate_job(BookmarkingCoursesJob, current_user, params[:password]) do
      alert = []
      alert << '非學生帳號' unless current_user.student?
      alert << '追蹤清單是空的' if current_user.favorite_courses.empty?
      alert << '密碼空白' if params[:password].blank?
      alert << '工作尚未結束' if @queued
      flash[:alert] = alert.join(', ') unless alert.empty?

      alert.empty?
    end
    
    redirect_to action: :show
  end

  private

  def job_state
    @queued = Rails.cache.fetch("course_export_status_#{current_user.id}")
  end
end
