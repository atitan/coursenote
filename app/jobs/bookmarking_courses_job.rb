class BookmarkingCoursesJob < ActiveJob::Base
  queue_as :default

  after_enqueue do |job|
    user = job.arguments.first
    logging(user.id, queued: true, message: '工作已排程')
  end

  after_perform do |job|
    user = job.arguments.first
    logging(user.id, queued: false, time: DateTime.now)
  end

  def perform(user, password)
    begin
      bookmarker = CsysHandler.new(user.student_id, password)
      bookmarker.login
      bookmarker.bookmark(user.favorite_courses)
      logging(user.id, message: '完成')
    rescue RuntimeError => e
      logging(user.id, message: e.message)
    rescue StandardError
      logging(user.id, message: '發生錯誤，請稍後再試')
    ensure
      bookmarker.logout
    end
  end

  private

    def logging(user_id, **args)
      state = JSON.parse($job_redis.get(user_id) || '{}')
      state.merge!(args)
      $job_redis.set(user_id, state.to_json)
    end
end
