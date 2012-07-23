set :application, "protocolo"
set :domain, "localhost"
set :deploy_to, "/home/deploy/#{application}"
set :user, "deploy"
set :use_sudo, false
set :keep_releases, 3

set :repository,  "https://github.com/cciuenf/protocolo.git"
set :scm, :git
set :scm_verbose, true

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :normalize_asset_timestamps, false

require "rvm/capistrano"
require "bundler/capistrano"
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
set :rvm_install_type, :head
set :rvm_install_ruby_params, '--1.9'      # for jruby/rbx default to 1.9 mode
set :rvm_ruby_string, "ruby-1.9.3-p194@protocolo"

default_environment["RAILS_ENV"] = 'production'

namespace :utils do
  task :compile_assets do
    run "cd #{latest_release}; bundle exec rake assets:precompile"
  end
  task :run_seed do
    run "cd #{latest_release}; bundle exec rake db:seed"
  end
  task :copy_config_file do
    run "cat ~/.protocolo/database.yml > #{latest_release}/config/database.yml"
    # run "cat ~/.protocolo/mail.yml > #{latest_release}/config/mail.yml"
  end
end

namespace :bundle do
  task :install do
    run "cd #{release_path} && bundle install --without test development --deployment"
  end
end

namespace :db do
  task :create do; run "cd #{release_path}; rake db:create"; end
  task :migrate do; run "cd #{release_path}; rake db:migrate"; end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

tasks = ["deploy:finalize_update", "utils:copy_config_file"]

after *tasks
after "deploy:update_code", "db:create", "db:migrate", "utils:compile_assets"