module CourseManager
  extend ActiveSupport::Concern

  def append_course(course)
    current_user.favorite_courses << course
    if current_user.save
      render json: current_user
    else
      render json: { error: current_user.errors.full_messages }, status: :internal_server_error
    end
  end

  def delete_course(course)
    if course
      current_user.favorite_courses.delete(course)
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