#$:.unshift(File.expand_path('/etc', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
#require "rvm/capistrano"                  # Load RVM's capistrano plugin.
require "bundler/capistrano"
#set :rvm_ruby_string, 'ruby-1.8.7-p330'        # Or whatever env you want it to run in.#
#set :rvm_type, :user
#set :rvm_bin_path, "/usr/local/bin/"

set :scm, :git
set :scm_user, 'gitolite'
set :branch, 'master'
set :user, 'pagerank-test.de'

set :application, "pagerank-test.de"
set :repository,  'git@github.com:henningthies/pagerank-test.de.git'

set :use_sudo, false
set :rails_env, 'staging'
set :app_port, '3180'

set :deploy_to, "/var/www/vhosts/#{application}/#{rails_env}"
set :deploy_via, :copy
set :ssh_options, {:forward_agent => true}

set :port, 22
role :app, "pagerank-test.de", :primary => true
#role :web, "vmhost.empuxa.com", :primary => true
#role :db, "vmhost.empuxa.com", :primary => true



after "deploy:symlink", "bundler:install"
namespace :bundler do
  task :install do
    run("export RAILS_ENV=#{rails_env} && cd #{current_path} && bundle install --deployment")
  end
end


namespace :deploy do

  task :restart do
    run "touch #{deploy_to}/tmp/restart.txt"
  end
  
  desc "Symlink the config files."
  after "deploy:symlink", "deploy:symlink_configs"
  task :symlink_configs do
    run "echo symlinking everything to #{release_path}"
    
    run "rm -fr #{release_path}/tmp"
    run "mkdir -p #{deploy_to}/shared/tmp/"
    run "ln -s #{deploy_to}/shared/tmp/ #{release_path}/tmp"

    #run "rm -fr #{release_path}/config/database.yml"
    #run "mkdir -p #{deploy_to}/shared/config/"
    #run "ln -s  #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    #
    #run "rm -fr #{release_path}/public/datas"
    #run "mkdir -p #{deploy_to}/shared/datas/"
    #run "ln -s #{deploy_to}/shared/datas/ #{release_path}/public/datas"
  end
  
  
end

namespace :rake do  
  desc "Run a task on a remote server."  
  # run like: cap staging rake:invoke task=a_certain_task  
  task :invoke do  
    run "cd #{deploy_to}/current && RAILS_ENV=#{rails_env} rake #{ENV['task']}"
  end  
end






