#! ruby -Ku

# Google Mapエンコード化ポリラインを扱うライブラリの試作コード


module GoogleMapsEncodedPolyline
  def self.decode_levels(data)
    return data.chars.map { |char|
      case char
      when "?" then 0
      when "@" then 1
      when "A" then 2
      when "B" then 3
      end
    }
  end
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

    def test_decode_levels
      assert_equal([],  @module.decode_levels(""))
      assert_equal([0], @module.decode_levels("?"))
      assert_equal([1], @module.decode_levels("@"))
      assert_equal([2], @module.decode_levels("A"))
      assert_equal([3], @module.decode_levels("B"))
    end
  end
end
