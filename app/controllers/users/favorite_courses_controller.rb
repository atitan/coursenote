class Users::FavoriteCoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_redis_state, only: [:show, :export]

  def show
    @courses = Course.show_favorite_courses(current_user.favorite_courses).includes(:entries, comments: :replies)
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

  def export
    unless @state[:queued]
      BookmarkingCoursesJob.perform_later(current_user, params[:csys_password])
    end
  end

  private

  def get_redis_state
    @state = JSON.parse($job_redis.get(current_user.id) || '{}')
  end
end
