
require "rake/testtask"
require "lib/googlemaps_polyline/version"

NAME = "nayutaya-googlemaps-polyline"

task :default => :test

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = Dir.glob("test/**/*_test.rb")
  test.verbose    =  true
end

desc "bump version"
task :bump do
  cur_version  = GoogleMapsPolyline::VERSION
  next_version = cur_version.succ
  puts("#{cur_version} -> #{next_version}")

  filename = File.join(File.dirname(__FILE__), "lib", "googlemaps_polyline", "version.rb")
  File.open(filename, "wb") { |file|
    file.puts(%|# coding: utf-8|)
    file.puts(%||)
    file.puts(%|module GoogleMapsPolyline|)
    file.puts(%|  VERSION = "#{next_version}"|)
    file.puts(%|end|)
  }
end

desc "generate gemspec"
task :gemspec do
  require "erb"

  src  = File.open("#{NAME}.gemspec.erb", "rb") { |file| file.read }
  erb  = ERB.new(src, nil, "-")

  version = GoogleMapsPolyline::VERSION
  date    = Time.now.strftime("%Y-%m-%d")

  files      = Dir.glob("**/*").select { |s| File.file?(s) }.reject { |s| /\.gem\z/ =~ s }
  test_files = Dir.glob("test/**").select { |s| File.file?(s) }

  File.open("#{NAME}.gemspec", "wb") { |file|
    file.write(erb.result(binding))
  }
end

desc "build gem"
task :build do
  sh "gem build #{NAME}.gemspec"
end

desc "push gem"
task :push do
  target = "#{NAME}-#{GoogleMapsPolyline::VERSION}.gem"
  sh "gem push #{target}"
end
