class PassedCoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = current_user.passed_courses
  end

  def create
    @course = current_user.passed_courses.new(passed_courses_param)
    if @course.save
      render json: @course
    else
      render json: { error: @course.errors.full_messages }, status: :internal_server_error
    end
  end

  def destroy
    @course = current_user.passed_courses.find(params[:id])
    if @course.destroy
      render json: @course
    else
      render json: { error: @course.errors.full_messages }, status: :internal_server_error
    end
  end

  private

  def passed_courses_param
    params.require(:passed_course).permit(:course_id)
  end
end
