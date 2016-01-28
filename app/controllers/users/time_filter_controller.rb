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
    output = {}
    time = time.split(',')

    time.each do |x|
      tmp = /([1-7])-([1-8ABCDEFG]+)/.match(x)
      next if tmp.nil?

      day = tmp[1].to_i
      sec = tmp[2].split('')
      output[day] = sec
    end
    
    output
  end
end
