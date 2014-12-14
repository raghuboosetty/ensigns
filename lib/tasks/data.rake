# encoding: utf-8

namespace :db do
  desc 'Run drop, create, migrate and seed at once'
   task all: :environment do
     all
   end
end

def all
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Rake::Task['db:drop'].invoke if database_exists?
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seed'].invoke
  completed
end

def show_progress
  print '.'
  $stdout.flush
end

def completed
  print "\nCompleted\n"
end

def database_exists?
  ActiveRecord::Base.connection
rescue ActiveRecord::NoDatabaseError
  false
else
  true
end