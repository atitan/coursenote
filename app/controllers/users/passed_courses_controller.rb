class Users::PassedCoursesController < ApplicationController
  include CourseManager

  before_action :authenticate_user!

  def show
    @list = current_user.passed_courses
  end

  def create
    if Course.where(title: params[:passed_course].to_s).empty?
      return redirect_to({ action: :show }, alert: '課程不存在')
    end

    append_course(:passed_courses, params[:passed_course])
  end

  def destroy
    delete_course(:passed_courses, params[:passed_course])
  end
end
