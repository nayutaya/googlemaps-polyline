# coding: utf-8

require "test_helper"
require "googlemaps_polyline/decoder"
require "stringio"

class DecoderTest < Test::Unit::TestCase
  def setup
    @klass   = GoogleMapsPolyline::Decoder
    @decoder = @klass.new(sio)
  end

  def test_initialize
    io = sio
    encoder = @klass.new(io)
    assert_same(io, encoder.io)
  end

  def test_decode_levels
    assert_equal([0, 1, 2, 3], @klass.new(sio("?@AB")).decode_levels)
  end

  def test_unpack_level
    unpack_level = proc { |char| @decoder.unpack_level(char) }
    assert_equal(0, unpack_level["?"])
    assert_equal(1, unpack_level["@"])
    assert_equal(2, unpack_level["A"])
    assert_equal(3, unpack_level["B"])
    assert_raise(ArgumentError) { unpack_level[""] }
  end

  private

  def sio(string = nil)
    return StringIO.new(string || "")
  end
end
