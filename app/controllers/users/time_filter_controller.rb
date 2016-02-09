class Users::TimeFilterController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    current_user.time_filter = convert2timetable(params[:time_filter])

    if current_user.save
      flash[:notice] = '修改成功'
    else
      flash[:alert] = '修改失敗'
    end
    redirect_to action: :show
  end

  private

  def convert2timetable(time)
    time = time.split(',')
    Entry.time_str_to_table(time)
  end
end
