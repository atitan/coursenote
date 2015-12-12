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
    if current_user.student? && !@state[:queued]
      BookmarkingCoursesJob.perform_later(current_user, params[:csys_password])
    else
      if current_user.student?
        redis_state(message: '工作尚未結束')
      else
        redis_state(message: '非學生帳號，請洽管理員')
      end
    end
  end

  private

  def redis_state(**args)
    @state = JSON.parse($job_redis.get(current_user.id) || '{}')
    @state.merge!(args)
    $job_redis.set(current_user.id, @state.to_json)
  end
end
