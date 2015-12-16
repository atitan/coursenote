class Users::PassedCoursesController < ApplicationController
  include CourseManager

  before_action :authenticate_user!

  def show
    @list = current_user.passed_courses
  end

  def create
    redirect_to action: :show, alert: '輸入錯誤' unless params[:passed_course].is_a?(String)
    append_course(:passed_courses, params[:passed_course])
  end

  def destroy
    delete_course(:passed_courses, params[:passed_course])
  end
end
