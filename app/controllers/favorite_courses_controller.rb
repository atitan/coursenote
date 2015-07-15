class FavoriteCoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = current_user.favorite_courses
  end

  def create
    @course = current_user.favorite_courses.new(favorite_courses_param)
    if @course.save
      render json: @course
    else
      render json: { error: @course.errors.full_messages }, status: :internal_server_error
    end
  end

  def destroy
    @course = current_user.favorite_courses.find(params[:id])
    if @course.destroy
      render json: @course
    else
      render json: { error: @course.errors.full_messages }, status: :internal_server_error
    end
  end

  private

  def favorite_courses_param
    params.require(:favorite_course).permit(:course_id)
  end
end