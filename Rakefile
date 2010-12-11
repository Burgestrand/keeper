require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'yard'
require 'jeweler'
require 'rspec/core/rake_task'
require './lib/keeper/version'

Jeweler::Tasks.new do |gem|
  gem.name     = "keeper"
  gem.homepage = "http://github.com/Burgestrand/keeper"
  gem.license  = "X11"
               
  gem.summary  = %Q{A thread-safe blocking event pattern for your pleasure.}
  gem.authors  = ["Kim Burgestrand"]
  gem.email    = "kim@burgestrand.se"
  
  gem.version  = Keeper::Version::STRING
end

Jeweler::RubygemsDotOrgTasks.new
YARD::Rake::YardocTask.new
RSpec::Core::RakeTask.new

task :default => :spec