#! ruby -Ku

# Google Mapエンコード化ポリラインを扱うライブラリの試作コード

require "stringio"

module GoogleMapsEncodedPolyline
end

if $0 == __FILE__
  require "test/unit"
  require "rubygems"
  begin
    require "redgreen"
    require "win32console" if /win32/ =~ RUBY_PLATFORM
  rescue LoadError
    # nop
  end

  class CoreTest < Test::Unit::TestCase
    def setup
      @module = GoogleMapsEncodedPolyline
    end

    private

    def sio(string = nil)
      return StringIO.new(string || "")
    end
  end
end
