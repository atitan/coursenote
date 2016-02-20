module CourseManager
  extend ActiveSupport::Concern

  def append_course(list_name, course)
    current_user.send(list_name).push(course)
    save_course(list_name, '新增')
  end

  def update_course(list_name, course)
    current_user.send("#{list_name}=", course)
    save_course(list_name, '更新')
  end

  def delete_course(list_name, course)
    if course
      current_user.send(list_name).delete(course)
    else
      current_user.send("#{list_name}=", [])
    end
    save_course(list_name, '刪除')
  end

  def save_course(list_name, action)
    if current_user.save
      respond_to do |format|
        format.html { redirect_to({ action: :show }, notice: "#{action}成功") }
        format.json { render json: current_user.as_json(only: list_name) }
      end
    else
      respond_to do |format|
        format.html { redirect_to({ action: :show }, alert: "#{action}失敗") }
        format.json { render json: { error: current_user.errors.full_messages }, status: 500 }
      end
    end
  end
end
