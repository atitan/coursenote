Devise::Async.setup do |config|
  config.enabled = true
  config.backend = :sidekiq
end