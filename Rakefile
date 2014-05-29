require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new   do |t|
  t.libs = ['lib','tests']
  t.test_files = Dir.glob('tests/**/*_test.rb').sort
  t.verbose = true
end

task :default => :test
