class Users::FavoriteCoursesController < ApplicationController
  include CourseManager

  before_action :authenticate_user!
  before_action :redis_state, only: [:show, :export]

  def show
    @entries = Entry.where(code: current_user.favorite_courses).includes(:course)
  end

  def create
    if Entry.where(code: params[:favorite_course]).empty?
      flash[:alert] = '課程不存在'
      return redirect_to action: :show
    end
    append_course(:favorite_courses, params[:favorite_course])
  end

  def destroy
    delete_course(:favorite_courses, params[:favorite_course])
  end

  def export
    return redirect_to users_favorite_courses_path unless current_user.student?

    if !current_user.favorite_courses.empty? && !@state[:queued] && !params[:password].blank?
      BookmarkingCoursesJob.perform_later(current_user, params[:password])
    else
      if current_user.favorite_courses.empty?
        flash[:alert] = '追蹤清單是空的'
      else
        flash[:alert] = '工作尚未結束或密碼空白'
      end
    end
    redirect_to users_favorite_courses_path
  end

  private

  def redis_state(**args)
    @state = JSON.parse($job_redis.get(current_user.id) || '{}')
    @state.merge!(args)
    $job_redis.set(current_user.id, @state.to_json)
  end
end
