class ImportClassScheduleJob < ApplicationJob
  queue_as :default

  after_enqueue do |job|
    @user = job.arguments.first
    flash(notice: '課表匯入已排程')
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

      schedule = csys.fetch_class_schedule
      full_time = {}
      (1..7).each{ |x| full_time[x.to_s] = %w(A 1 2 3 4 B 5 6 7 8 C D E F G) }
      user.update(time_filter: full_time.easy_unmerge(schedule))

      csys.logout
      flash(notice: '課表匯入完成')
    rescue RuntimeError => e
      flash(alert: "課表匯入失敗：#{e.message}")
    rescue StandardError
      flash(alert: '課表匯入錯誤，請稍後再試')
    end
  end

  private

  def queued(status)
    Rails.cache.write("class_schedule_import_status_#{@user.id}", status)
  end

  def flash(**args)
    Rails.cache.write("user_flash_#{@user.id}", args)
  end
end
