class Users::PassedCoursesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def create
    current_user.passed_courses << params[:passed_course]
    if current_user.save
      render json: current_user
    else
      render json: { error: current_user.errors.full_messages }, status: :internal_server_error
    end
  end

  def destroy
    if params[:passed_course]
      current_user.passed_courses.delete(params[:passed_course])
    else
      current_user.passed_courses = []
    end
    
    if current_user.save
      render json: current_user
    else
      render json: { error: current_user.errors.full_messages }, status: :internal_server_error
    end
  end
end
