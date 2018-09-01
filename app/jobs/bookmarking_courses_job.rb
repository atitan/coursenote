class BookmarkingCoursesJob < ApplicationJob
  queue_as :default

  after_enqueue do |job|
    @user = job.arguments.first
    flash(notice: '課程匯出已排程')
    queued(true)
  end

  after_perform do |job|
    @user = job.arguments.first
    queued(false)
  end

  def perform(user, password)
    @user = user
    begin
      csys = CsysHandler.new(user.student_id, password)
      csys.login
      csys.bookmark(user.favorite_courses)
      csys.logout
      flash(notice: '課程匯出完成')
    rescue RuntimeError => e
      flash(alert: "課程匯出失敗：#{e.message}")
    rescue StandardError
      flash(alert: '課程匯出錯誤，請稍後再試')
    end
  end

  private

  def queued(status)
    Rails.cache.write("course_export_status_#{@user.id}", status)
  end

  def flash(**args)
    Rails.cache.write("user_flash_#{@user.id}", args)
  end
end
