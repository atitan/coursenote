class Users::FavoriteCoursesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def create
    current_user.favorite_courses << params[:favorite_course]
    if current_user.save
      render json: current_user
    else
      render json: { error: current_user.errors.full_messages }, status: :internal_server_error
    end
  end

  def destroy
    if params[:favorite_course]
      current_user.favorite_courses.delete(params[:favorite_course])
    else
      current_user.favorite_courses = []
    end
    
    if current_user.save
      render json: current_user
    else
      render json: { error: current_user.errors.full_messages }, status: :internal_server_error
    end
  end
end
