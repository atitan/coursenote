workers Integer(2)
threads_count = Integer(5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        8000
environment 'production'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
