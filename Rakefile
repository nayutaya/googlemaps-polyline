
require "rake/testtask"
require "lib/googlemaps_polyline/version"

PACKAGE_NAME    = "nayutaya-googlemaps-polyline"
PACKAGE_VERSION = GoogleMapsPolyline::VERSION

task :default => :test

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = Dir.glob("test/**/*_test.rb")
  test.verbose    =  true
end

namespace :version do
  desc "show current version"
  task :show do
    puts(PACKAGE_VERSION)
  end

  desc "bump version"
  task :bump do
    cur_version  = PACKAGE_VERSION
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
end

namespace :gem do
  desc "generate gemspec"
  task :spec do
    require "erb"

    src = File.open("#{PACKAGE_NAME}.gemspec.erb", "rb") { |file| file.read }
    erb = ERB.new(src, nil, "-")

    files = Dir.glob("**/*").
      select { |s| File.file?(s) }.
      reject { |s| /\.gem\z/ =~ s }.
      reject { |s| /\Anbproject\// =~ s }

    test_files = Dir.glob("test/**").
      select { |s| File.file?(s) }

    File.open("#{PACKAGE_NAME}.gemspec", "wb") { |file|
      file.write(erb.result(binding))
    }
  end

  desc "build gem"
  task :build do
    sh "gem build #{PACKAGE_NAME}.gemspec"
  end

  desc "push gem"
  task :push do
    target = "#{PACKAGE_NAME}-#{PACKAGE_VERSION}.gem"
    sh "gem push #{target}"
  end
end
