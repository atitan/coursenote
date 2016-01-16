class Users::PassedCoursesController < ApplicationController
  include CourseManager

  before_action :authenticate_user!

  def show
    @list = current_user.passed_courses
  end

  def create
    return redirect_to({action: :show}, alert: '課程不存在') if Entry.where(title: params[:passed_course].to_s).empty?

    append_course(:passed_courses, params[:passed_course])
  end

  def destroy
    delete_course(:passed_courses, params[:passed_course])
  end
end
