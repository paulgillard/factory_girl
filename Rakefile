require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rcov/rcovtask'
require 'date'

require 'spec/rake/spectask'
require 'cucumber/rake/task'

desc 'Default: run the specs and features.'
task :default => [:spec, :features]

Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ['--options', "spec/spec.opts"]
end

desc 'Performs code coverage on the factory_girl plugin.'
Rcov::RcovTask.new do |t|
  t.test_files = FileList['spec/*_spec.rb']
  t.verbose = true
end

desc 'Generate documentation for the factory_girl plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Factory Girl'
  rdoc.options << '--line-numbers' << "--main" << "README.rdoc"
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('CONTRIBUTION_GUIDELINES.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Update documentation on website'
task :sync_docs => 'rdoc' do
  `rsync -ave ssh rdoc/ dev@dev.thoughtbot.com:/home/dev/www/dev.thoughtbot.com/factory_girl`
end

spec = Gem::Specification.new do |s|
  s.name        = %q{factory_girl}
  s.version     = "1.2.3"
  s.summary     = %q{factory_girl provides a framework and DSL for defining and
                     using model instance factories.}
  s.description = %q{factory_girl provides a framework and DSL for defining and
                     using factories - less error-prone, more explicit, and
                     all-around easier to work with than fixtures.}

  s.files        = FileList['[A-Z]*', 'lib/**/*.rb', 'spec/**/*.rb']
  s.require_path = 'lib'
  s.test_files   = Dir[*['spec/**/*_spec.rb']]

  s.has_rdoc         = true
  s.extra_rdoc_files = ["README.rdoc"]
  s.rdoc_options = ['--line-numbers', "--main", "README.rdoc"]

  s.authors = ["Joe Ferris"]
  s.email   = %q{jferris@thoughtbot.com}
  s.homepage = "http://thoughtbot.com/community"

  s.platform = Gem::Platform::RUBY

  s.add_runtime_dependency "activesupport"
  s.add_development_dependency "activerecord"
  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rr"
end

Rake::GemPackageTask.new spec do |pkg|
  pkg.need_tar = true
  pkg.need_zip = true
end

desc "Clean files generated by rake tasks"
task :clobber => [:clobber_rdoc, :clobber_package]

desc "Generate a gemspec file"
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end

Cucumber::Rake::Task.new(:features) do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end
