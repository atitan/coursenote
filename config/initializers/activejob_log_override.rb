ActiveSupport.on_load :active_job do
  class ActiveJob::Logging::LogSubscriber
    private def args_info(job)
      if job.arguments.any?
        if job.class.name == 'BookmarkingCoursesJob'
          args = job.arguments.first.to_global_id.inspect
        else
          args = job.arguments.map { |arg| format(arg).inspect }.join(', ')
        end
        ' with arguments: ' + args
      else
        ''
      end
    end
  end
end
