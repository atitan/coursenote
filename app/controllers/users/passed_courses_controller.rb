class Users::PassedCoursesController < ApplicationController
  include UserDataManager

  before_action :authenticate_user!

  def show
    @list = current_user.passed_courses
  end

  def create
    userdata_append(:passed_courses, params[:passed_course]) do
      if Course.where(title: params[:passed_course].to_s).empty?
        flash[:alert] = '課程不存在'
        next false
      end

      true
    end
  end

  def destroy
    userdata_delete(:passed_courses, params[:passed_course])
  end
end
