set :stage, :staging
set :rails_env, :staging
set :domain, 'rcore.vgg.ru'

role :web, fetch(:domain)
role :app, fetch(:domain)
role :db,  fetch(:domain), primary: true

set :branch, 'master'
set :deploy_to, '/opt/www/rapi-stage'
set :tmp_dir, '/var/www/tmp'


set :bundle_flags, '--deployment'

set :ssh_options, {
    forward_agent: true,
    user: 'www-data',
}

set :passenger_restart_with_touch, true
set :rvm_ruby_version, 'ruby-2.5.3@rapi'

append :linked_files, 'config/application.yml', 'config/master.key'
append :linked_dirs, 'log', 'tmp'
