require 'net/ssh/proxy/command'

# config valid only for Capistrano 3.1
# lock '3.6.1'

set :application, 'png'
set :repo_url, 'git@gitlab.com:geekineers/png-trucking.git'
set :deploy_via, :remote_cache
set :bundle_without, [:development, :test]

set :log_level, :debug
set :linked_files, %w{config/redis.yml config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle config/thin}

set :keep_releases, 1
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_flags, '--deployment'

set :rvm_ruby_version, '2.4.0@truck-rms'
set :deploy_to, "/home/ubuntu/png"


load "config/deploy/tasks.rb"


namespace :deploy do
  after :publishing, :restart
end
