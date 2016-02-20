class Users::TimeFilterController < ApplicationController
  before_action :authenticate_user!
  before_action :job_state, only: :import

  def show
  end

  def update
    current_user.time_filter = Entry.time_str_to_table(params[:time_filter].split(','))

    if current_user.save
      flash[:notice] = '修改成功'
    else
      flash[:alert] = '修改失敗'
    end
    redirect_to action: :show
  end

  def import
    return redirect_to(action: :show) unless validate_input

    ImportClassScheduleJob.perform_later(current_user, params[:password])
    redirect_to action: :show
  end

  private

  def validate_input
    alert = []
    alert << '非學生帳號' unless current_user.student?
    alert << '密碼空白' if params[:password].blank?
    alert << '工作尚未結束' if @queued

    return true if alert.empty?

    flash[:alert] = alert.join(', ')
    false
  end

  def job_state
    @queued = Rails.cache.fetch("class_schedule_import_status_#{current_user.id}")
  end
end
