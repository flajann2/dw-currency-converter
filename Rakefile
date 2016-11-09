# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'semver'

def s_version
  SemVer.find.format "%M.%m.%p%s"
end

require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "dw-currency-converter"
  gem.homepage = "http://github.com/flajann2/dw-currency-converter"
  gem.license = "MIT"
  gem.summary = %Q{Simple Conversion between currencies using a base currency.}
  gem.description = %Q{Convert between any two specified currencies.
 This is not ready for prime-time usage yet, but
 can be used for now in non-production code.}
  gem.email = "fred.mitchell@gmx.de"
  gem.authors = ["Fred Mitchell"]
  gem.version = s_version
  gem.required_ruby_version = '>= 2.3.1'

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
