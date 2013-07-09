set :application, "protocolo"
set :domain, "172.20.5.107"
set :deploy_to, "/home/deploy/#{application}"
set :user, "deploy"
set :use_sudo, false
set :keep_releases, 3

default_run_options[:pty] = true # allow pseudo-terminals
ssh_options[:forward_agent] = true # forward SSH keys (this will use your SSH key to get the code from git repository)
ssh_options[:port] = 22

set :repository,  "https://github.com/cciuenf/protocolo.git"
set :scm, :git

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :normalize_asset_timestamps, false

require "rvm/capistrano"
require "bundler/capistrano"
set :bundle_without,  [:development]
set :rvm_install_type, :head
set :rvm_install_ruby_params, '--1.9'      # for jruby/rbx default to 1.9 mode
set :rvm_ruby_string, "2.0.0-p247@protocolo"
set :rvm_install_ruby, :install
set :rvm_install_shell, :bash

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
    run "cd #{release_path} && bundle install --without test development"
  end
end

namespace :db do
  task :create do; run "cd #{release_path}; bundle exec rake db:create"; end
  task :migrate do; run "cd #{release_path}; bundle exec rake db:migrate"; end
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
