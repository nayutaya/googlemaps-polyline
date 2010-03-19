#! ruby -Ku

# Google Mapエンコード化ポリラインを扱うライブラリの試作コード

require "stringio"

module GoogleMapsEncodedPolyline
  def self.encode_levels(io, levels)
    levels.each { |level|
      case level
      when 0 then io.write("?")
      when 1 then io.write("@")
      when 2 then io.write("A")
      when 3 then io.write("B")
      else raise(ArgumentError)
      end
    }

    return io
  end

  def self.decode_levels(io)
    levels = []

    while (char = io.read(1))
      case char
      when "?" then levels << 0
      when "@" then levels << 1
      when "A" then levels << 2
      when "B" then levels << 3
      else raise(ArgumentError)
      end
    end

    return levels
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
      assert_equal("",  @module.encode_levels(sio, []).string)
      assert_equal("?", @module.encode_levels(sio, [0]).string)
      assert_equal("@", @module.encode_levels(sio, [1]).string)
      assert_equal("A", @module.encode_levels(sio, [2]).string)
      assert_equal("B", @module.encode_levels(sio, [3]).string)
    end

    def test_encode_levels__multiple
      assert_equal("?@AB", @module.encode_levels(sio, [0, 1, 2, 3]).string)
    end

    def test_encode_levels__invalid
      assert_raise(ArgumentError) {
        @module.encode_levels(sio, [-1])
      }
    end

    def test_decode_levels__simple
      assert_equal([],  @module.decode_levels(sio("")))
      assert_equal([0], @module.decode_levels(sio("?")))
      assert_equal([1], @module.decode_levels(sio("@")))
      assert_equal([2], @module.decode_levels(sio("A")))
      assert_equal([3], @module.decode_levels(sio("B")))
    end

    def test_decode_levels__multiple
      assert_equal([0, 1, 2, 3], @module.decode_levels(sio("?@AB")))
    end

    def test_decode_levels__invalid
      assert_raise(ArgumentError) {
        @module.decode_levels(sio(" "))
      }
    end

    private

    def sio(string = nil)
      return StringIO.new(string || "")
    end
  end
end
