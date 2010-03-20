# coding: utf-8

require "test_helper"
require "googlemaps_polyline/encoder"
require "stringio"

class EncoderTest < Test::Unit::TestCase
  def setup
    @klass = GoogleMapsPolyline::Encoder
  end

  def test_initialize
    io = sio
    @encoder = @klass.new(io)
    assert_same(io, @encoder.io)
  end

  def test_write_num
    assert_equal("?"     , @klass.write_num(sio,         0).string)
    assert_equal("A"     , @klass.write_num(sio,         1).string)
    assert_equal("@"     , @klass.write_num(sio,        -1).string)
    assert_equal("{sopV" , @klass.write_num(sio,  12345678).string)
    assert_equal("zsopV" , @klass.write_num(sio, -12345678).string)
    assert_equal("_gsia@", @klass.write_num(sio,  18000000).string)
    assert_equal("~fsia@", @klass.write_num(sio, -18000000).string)
  end

  def test_encode_points
    assert_equal(
      "",
      @klass.encode_points(sio, []).string)
    assert_equal(
      "??",
      @klass.encode_points(sio, [[0, 0]]).string)
    assert_equal(
      "????",
      @klass.encode_points(sio, [[0, 0], [0, 0]]).string)
    assert_equal(
      "A?",
      @klass.encode_points(sio, [[1, 0]]).string)
    assert_equal(
      "?A",
      @klass.encode_points(sio, [[0, 1]]).string)
    assert_equal(
      "AA??",
      @klass.encode_points(sio, [[1, 1], [1, 1]]).string)
    assert_equal(
      "ACACAGAOA_@",
      @klass.encode_points(sio, [[1, 2], [2, 4], [3, 8], [4, 16], [5, 32]]).string)
  end

  private

  def sio(string = nil)
    return StringIO.new(string || "")
  end
end
