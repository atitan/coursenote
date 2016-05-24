module JobSupervisor
  extend ActiveSupport::Concern

  def delegate_job(job, *params, &check)
    if block_given?
      validated = yield check
      return false unless validated
    end

    job.perform_later(*params)
  end
end
