# coding: utf-8

$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "test/unit"

begin
  require "rubygems"
  require "redgreen"
  require "win32console" if /win32/ =~ RUBY_PLATFORM
rescue LoadError
  # nop
end
