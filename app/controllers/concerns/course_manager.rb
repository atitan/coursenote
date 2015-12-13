module CourseManager
  extend ActiveSupport::Concern

  def append_course(list_name, course)
    current_user.send(list_name).push(course)
    if current_user.save
      render json: current_user
    else
      render json: { error: current_user.errors.full_messages }, status: :internal_server_error
    end
  end

  def delete_course(list_name, course)
    if course
      current_user.send(list_name).delete(course)
    else
      current_user.send("#{list_name}=", [])
    end
    
    if current_user.save
      render json: current_user
    else
      render json: { error: current_user.errors.full_messages }, status: :internal_server_error
    end
  end
end