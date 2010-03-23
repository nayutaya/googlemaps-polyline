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

  def test_decode_points__1
    assert_equal(
      [[0, 0]],
      @klass.new(sio("??")).decode_points)
  end

  def test_decode_points__2
    assert_equal(
      [[0, 0], [0, 0]],
      @klass.new(sio("????")).decode_points)
  end

  def test_decode_points__3
    assert_equal(
      [[1, 0]],
      @klass.new(sio("A?")).decode_points)
  end

  def test_decode_points__4
    assert_equal(
      [[0, 1]],
      @klass.new(sio("?A")).decode_points)
  end

  def test_decode_points__5
    assert_equal(
      [[1, 1], [1, 1]],
      @klass.new(sio("AA??")).decode_points)
  end

  def test_decode_points__6
    assert_equal(
      [[1, 2], [2, 4], [3, 8], [4, 16], [5, 32]],
      @klass.new(sio("ACACAGAOA_@")).decode_points)
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

  # FIXME: 削除予定
  def test_read_fragment
    assert_equal(        0, @klass.read_fragment(sio("?")))
    assert_equal(        1, @klass.read_fragment(sio("A")))
    assert_equal(       -1, @klass.read_fragment(sio("@")))
    assert_equal( 12345678, @klass.read_fragment(sio("{sopV")))
    assert_equal(-12345678, @klass.read_fragment(sio("zsopV")))
    assert_equal( 18000000, @klass.read_fragment(sio("_gsia@")))
    assert_equal(-18000000, @klass.read_fragment(sio("~fsia@")))
  end

  # FIXME: 削除予定
  def test_read_fragment__invalid
    assert_raise(ArgumentError) {
      @klass.read_fragment(sio(""))
    }
  end

  def test_read_point
    read_point = proc { |io| @decoder.instance_eval { read_point(io) } }
    assert_equal(        0, read_point[sio("?")])
    assert_equal(        1, read_point[sio("A")])
    assert_equal(       -1, read_point[sio("@")])
    assert_equal( 12345678, read_point[sio("{sopV")])
    assert_equal(-12345678, read_point[sio("zsopV")])
    assert_equal( 18000000, read_point[sio("_gsia@")])
    assert_equal(-18000000, read_point[sio("~fsia@")])
    assert_raise(ArgumentError) { read_point[sio("")] }
  end

  def test_read_level
    read_level = proc { |io| @decoder.instance_eval { read_level(io) } }
    assert_equal(0, read_level[sio("?")])
    assert_equal(1, read_level[sio("@")])
    assert_equal(2, read_level[sio("A")])
    assert_equal(3, read_level[sio("B")])
    assert_raise(ArgumentError) { read_level[sio("")] }
  end

  private

  def sio(string = nil)
    return StringIO.new(string || "")
  end
end
