class Users::TimeFilterController < ApplicationController
  include UserDataManager
  include JobSupervisor

  before_action :authenticate_user!
  before_action :job_state, only: :import

  def show
  end

  def update
    timetable = Entry.time_str_to_table(params[:time_filter].split(','))
    userdata_update(:time_filter, timetable)

    redirect_to action: :show
  end

  def import
    delegate_job(ImportClassScheduleJob, current_user, params[:password]) do
      alert = []
      alert << '非學生帳號' unless current_user.student?
      alert << '密碼空白' if params[:password].blank?
      alert << '工作尚未結束' if @queued
      flash[:alert] = alert.join(', ') unless alert.empty?

      alert.empty?
    end

    redirect_to action: :show
  end

  private

  def job_state
    @queued = Rails.cache.fetch("class_schedule_import_status_#{current_user.id}")
  end
end
