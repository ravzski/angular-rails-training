set :stage, :production
set :rails_env, 'production'
set :branch, "develop"

server '0.tcp.ngrok.io',
  user: 'ubuntu',
  port: '10337',
  password: 'gaNguu3W',
  roles: %w{web app db}
