# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  # exit e.status_code
end
require 'rake'
require 'lib/mustache_i18n_rails'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "mustache_i18n_rails"
  gem.version = Mustache::I18n::VERSION
  gem.homepage = "http://github.com/AnthonyCaliendo/mustache_i18n_rails"
  gem.license = "MIT"
  gem.summary = %Q{Adds I18n support to mustache for a Rails app.}
  gem.description = %Q{Adds I18n support to mustache for use in a Rails app.  Hooks into Rails I18n functionality, allowing seamless internationalization and localization support for mustache templates.}
  gem.email = "anthonycaliendo@emailredirect.cjb.net"
  gem.authors = ["Anthony Caliendo"]
  gem.require_path = 'lib'
  gem.files = %w(LICENSE README.rdoc Rakefile) + Dir.glob("{lib,test}/**/*")
end
Jeweler::RubygemsDotOrgTasks.new

desc 'Default: run unit tests'
task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = Mustache::I18n::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mustache_i18n_rails #{version}"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  gem 'rspec', '>= 1.2.6'
  require 'spec'
  require 'spec/rake/spectask'
rescue LoadError
  begin
    require 'rspec/core/rake_task.rb'
    require 'rspec/core/version'
  rescue LoadError
    puts 'RSpec is not available. Install it with: gem install rspec'
  end
end

if defined?(Spec)
  desc 'Run unit tests'
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.spec_opts = ['-c']
  end
end

if defined?(RSpec)
  desc 'Run unit tests'
  RSpec::Core::RakeTask.new('spec') do |t|
    t.pattern = FileList['spec/**/*_spec.rb']
  end
end