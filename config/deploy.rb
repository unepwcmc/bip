# config valid only for current version of Capistrano
lock '3.17.1'

set :application, 'bip'
set :repo_url, 'git@github.com:unepwcmc/bip.git'


set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v12.18.3'
set :nvm_map_bins, %w{node npm yarn}

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp


set :deploy_user, 'wcmc'


set :backup_path, "/home/#{fetch(:deploy_user)}/Backup"



# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:deploy_user)}/#{fetch(:application)}"

# Default value for :scm is :git
set :scm, :git
set :scm_username, "unepwcmc-read"


set :rvm_type, :user
set :rvm_ruby_version, '2.3.1'

namespace :npm do
  desc 'Install dependencies with npm'
  task :install do
    on roles(:web) do
      within release_path do
        execute "bash -c 'source ~/.nvm/nvm.sh && nvm use 12.18.3 && cd '#{release_path}' && npm install'"
      end
    end
  end
end


#before 'deploy:starting', 'npm:install'

before 'deploy:compile_assets', 'npm:install'


set :ssh_options, {
  forward_agent: true,
}


# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
#set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
#set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

set :linked_files, %w{config/database.yml .env} 

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/.well-known')


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :passenger_restart_with_touch, false
