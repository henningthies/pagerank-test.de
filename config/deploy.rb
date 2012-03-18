$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
require "bundler/capistrano"

load "deploy/assets"
set :normalize_asset_timestamps, false
set :rvm_ruby_string, 'ruby-1.9.3-p0@pagerank'        # Or whatever env you want it to run in.#
set :rvm_type, :system

set :scm, :git
set :branch, '3.2'
set :user, 'deploy'

set :application, "pagerank"
set :deploy_to, "/home/deploy/pagerank/"

set :use_sudo, false
set :rails_env, 'production'

set :deploy_via, :remote_cache
set :repository,  'git@github.com:henningthies/pagerank-test.de.git'
set :ssh_options, {:forward_agent => true}
set :port, 22100

role :app, "dev.henning-thies.de", :primary => true
role :web, "dev.henning-thies.de", :primary => true

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
end


