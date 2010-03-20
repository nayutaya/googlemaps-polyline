# coding: utf-8

require "test_helper"
require "googlemaps_polyline/encoder"
require "stringio"

class EncoderTest < Test::Unit::TestCase
  def setup
    @klass   = GoogleMapsPolyline::Encoder
    @encoder = @klass.new(sio)
  end

  def test_initialize
    io = sio
    encoder = @klass.new(io)
    assert_same(io, encoder.io)
  end

  def test_write_num
    assert_equal("?"     , @klass.new(sio).write_num(        0).string)
    assert_equal("A"     , @klass.new(sio).write_num(        1).string)
    assert_equal("@"     , @klass.new(sio).write_num(       -1).string)
    assert_equal("{sopV" , @klass.new(sio).write_num( 12345678).string)
    assert_equal("zsopV" , @klass.new(sio).write_num(-12345678).string)
    assert_equal("_gsia@", @klass.new(sio).write_num( 18000000).string)
    assert_equal("~fsia@", @klass.new(sio).write_num(-18000000).string)
  end

  def test_encode_points__1
    assert_equal(
      "",
      @encoder.encode_points([]).string)
  end

  def test_encode_points__2
    assert_equal(
      "??",
      @encoder.encode_points([[0, 0]]).string)
  end

  def test_encode_points__3
    assert_equal(
      "????",
      @encoder.encode_points([[0, 0], [0, 0]]).string)
  end

  def test_encode_points__4
    assert_equal(
      "A?",
      @encoder.encode_points([[1, 0]]).string)
  end

  def test_encode_points__5
    assert_equal(
      "?A",
      @encoder.encode_points([[0, 1]]).string)
  end

  def test_encode_points__6
    assert_equal(
      "AA??",
      @encoder.encode_points([[1, 1], [1, 1]]).string)
  end

  def test_encode_points__7
    assert_equal(
      "ACACAGAOA_@",
      @encoder.encode_points([[1, 2], [2, 4], [3, 8], [4, 16], [5, 32]]).string)
  end

  private

  def sio(string = nil)
    return StringIO.new(string || "")
  end
end
