default_run_options[:pty] = true
set :spinner_user, nil
set :application, "addressbook"
set :repository,  "git@github.com:wolas/addressbook.git"
set :scm, :git
set :scm_username, "wolas"
set :user, :yruser
set :deploy_to, "/home/yruser/apps/#{application}"
set :scm_passphrase, "deploypassword"
set :branch, "master"

server "152.146.39.15", :app, :web, :db, :primary => true
