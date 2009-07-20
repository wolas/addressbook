default_run_options[:pty] = true
set :spinner_user, nil
set :runner, :yruser
set :application, "addressbook"
set :repository,  "git@github.com:wolas/addressbook.git"
set :user, :yruser
set :deploy_to, "/home/yruser/apps/#{application}"
set :branch, "master"

set :scm, :git
set :scm_username, "wolas"
set :scm_passphrase, "deploypassword"

server "152.146.39.15", :app, :web, :db, :primary => true

after "deploy:update_code", :fix_script_perms
task :fix_script_perms do
  run "chmod 755 #{latest_release}/script/spin"
end
