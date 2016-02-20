ActiveSupport.on_load :active_job do
  class ActiveJob::Logging::LogSubscriber
    private def args_info(job)
      ''
    end
  end
end
