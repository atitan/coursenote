class BookmarkingCoursesJob < ActiveJob::Base
  queue_as :default

  after_enqueue do |job|
    user = job.arguments.first
    logging(user.id, queued: true)
  end

  after_perform do |job|
    user = job.arguments.first
    logging(user.id, queued: false, locked_until: DateTime.now + 1.minutes)
  end

  def perform(user, csys_password)
    begin
      bookmarker = CycuCsysBookmarker.new(user.student_id, csys_password)
      bookmarker.login
      bookmarker.bookmark(user.favorite_courses)
      logging(user.id, message: '完成')
      bookmarker.logout
    rescue RuntimeError => e
      logging(user.id, message: e.message)
    rescue StandardError => e
      logging(user.id, message: '發生錯誤，請稍後再試')
    end
  end

  private

    def logging(user_id, **args)
      state = JSON.parse($job_redis.get(user_id) || '{}')
      state.merge!(args)
      $job_redis.set(user_id, state.to_json)
    end
end
