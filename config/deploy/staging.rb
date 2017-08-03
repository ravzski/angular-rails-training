set :stage, :production
set :rails_env, 'production'
set :branch, "develop"

server '54.255.177.212',
  user: 'ubuntu',
  roles: %w{web app db}
