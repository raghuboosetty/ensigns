lock '3.2.1'
set :rvm_type, :system
set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :application, 'ensigns'
set :repo_url, 'git@github.com:raghuboosetty/ensigns.git'
set :branch, "master"
set :deploy_user, "root"
set :deploy_to, "/#{fetch(:deploy_user)}/apps/#{fetch(:application)}"
set :scm, :git
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :keep_releases, 2

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  after :publishing, :restart
end