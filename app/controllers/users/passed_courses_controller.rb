class Users::PassedCoursesController < ApplicationController
  include CourseManager

  before_action :authenticate_user!

  def show
  end

  def create
    append_course(:passed_courses, params[:passed_course])
  end

  def destroy
    delete_course(:passed_courses, params[:passed_course])
  end
end
