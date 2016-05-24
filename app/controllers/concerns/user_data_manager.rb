module UserDataManager
  extend ActiveSupport::Concern

  def userdata_append(list_name, course, &check)
    if block_given?
      validated = yield check
      return false unless validated
    end

    current_user.send(list_name).push(course)
    save_user(list_name, '新增')
  end

  def userdata_update(list_name, course)
    current_user.send("#{list_name}=", course)
    save_user(list_name, '更新')
  end

  def userdata_delete(list_name, course)
    if course
      current_user.send(list_name).delete(course)
    else
      current_user.send("#{list_name}=", [])
    end
    save_user(list_name, '刪除')
  end

  def save_user(list_name, action)
    if current_user.save
      flash[:notice] = "#{action}成功"
    else
      flash[:alert] = "#{action}失敗"
    end
  end
end
