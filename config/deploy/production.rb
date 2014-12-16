set :stage, :production
set :rails_env, :production
server '104.236.105.66', user: 'root', port: 22, roles: %w{web app db}, primary: true