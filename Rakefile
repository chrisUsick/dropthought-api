# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks
desc 'Raise an error unless development environment'
task :safety_check do
  raise 'You can only use this in dev!' unless Rails.env.development?
end

namespace :db do
  desc 'Drop, create, migrate then seed the development database'
  task reseed: [
    'environment',
    'safety_check',
    'db:reset',
    'db:seed'
  ]
end
