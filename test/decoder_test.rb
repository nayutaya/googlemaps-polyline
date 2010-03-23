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

  def test_decode_polyline__simple
    assert_equal(
      [[0, 0]],
      @klass.decode_polyline(sio("??")))
    assert_equal(
      [[0, 0], [0, 0]],
      @klass.decode_polyline(sio("????")))
    assert_equal(
      [[1, 0]],
      @klass.decode_polyline(sio("A?")))
    assert_equal(
      [[0, 1]],
      @klass.decode_polyline(sio("?A")))
    assert_equal(
      [[1, 1], [1, 1]],
      @klass.decode_polyline(sio("AA??")))
    assert_equal(
      [[1, 2], [2, 4], [3, 8], [4, 16], [5, 32]],
      @klass.decode_polyline(sio("ACACAGAOA_@")))
  end

  def test_decode_polyline__invalid
    assert_raise(ArgumentError) {
      @klass.decode_polyline(sio("?"))
    }
  end

  def test_decode_levels
    assert_equal([0, 1, 2, 3], @klass.new(sio("?@AB")).decode_levels)
  end

  def test_read_fragment
    assert_equal(        0, @klass.read_fragment(sio("?")))
    assert_equal(        1, @klass.read_fragment(sio("A")))
    assert_equal(       -1, @klass.read_fragment(sio("@")))
    assert_equal( 12345678, @klass.read_fragment(sio("{sopV")))
    assert_equal(-12345678, @klass.read_fragment(sio("zsopV")))
    assert_equal( 18000000, @klass.read_fragment(sio("_gsia@")))
    assert_equal(-18000000, @klass.read_fragment(sio("~fsia@")))
  end

  def test_read_fragment__invalid
    assert_raise(ArgumentError) {
      @klass.read_fragment(sio(""))
    }
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
