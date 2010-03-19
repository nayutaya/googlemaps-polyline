#! ruby -Ku

# Google Mapエンコード化ポリラインを扱うライブラリの試作コード


module GoogleMapsEncodedPolyline
  def self.encode_levels(levels)
    return levels.map { |level|
      case level
      when 0 then "?"
      when 1 then "@"
      when 2 then "A"
      when 3 then "B"
      else raise(ArgumentError)
      end
    }.join("")
  end

  def self.decode_levels(data)
    return data.chars.map { |char|
      case char
      when "?" then 0
      when "@" then 1
      when "A" then 2
      when "B" then 3
      else raise(ArgumentError)
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

    def test_encode_levels__simple
      assert_equal("",  @module.encode_levels([]))
      assert_equal("?", @module.encode_levels([0]))
      assert_equal("@", @module.encode_levels([1]))
      assert_equal("A", @module.encode_levels([2]))
      assert_equal("B", @module.encode_levels([3]))
    end

    def test_encode_levels__multiple
      assert_equal("?@AB",  @module.encode_levels([0, 1, 2, 3]))
    end

    def test_encode_levels__invalid
      assert_raise(ArgumentError) {
        @module.encode_levels([-1])
      }
    end

    def test_decode_levels__simple
      assert_equal([],  @module.decode_levels(""))
      assert_equal([0], @module.decode_levels("?"))
      assert_equal([1], @module.decode_levels("@"))
      assert_equal([2], @module.decode_levels("A"))
      assert_equal([3], @module.decode_levels("B"))
    end

    def test_decode_levels__multiple
      assert_equal([0, 1, 2, 3],  @module.decode_levels("?@AB"))
    end

    def test_decode_levels__invalid
      assert_raise(ArgumentError) {
        @module.decode_levels(" ")
      }
    end
  end
end
