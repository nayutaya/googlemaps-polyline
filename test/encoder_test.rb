# coding: utf-8

require "test_helper"
require "googlemaps_polyline/encoder"
require "stringio"

class EncoderTest < Test::Unit::TestCase
  def setup
    @mod = GoogleMapsPolyline::Encoder
  end

  def test_write_num
    assert_equal("?"     , @mod.write_num(sio,         0).string)
    assert_equal("A"     , @mod.write_num(sio,         1).string)
    assert_equal("@"     , @mod.write_num(sio,        -1).string)
    assert_equal("{sopV" , @mod.write_num(sio,  12345678).string)
    assert_equal("zsopV" , @mod.write_num(sio, -12345678).string)
    assert_equal("_gsia@", @mod.write_num(sio,  18000000).string)
    assert_equal("~fsia@", @mod.write_num(sio, -18000000).string)
  end

  def test_encode_points
    assert_equal(
      "",
      @mod.encode_points(sio, []).string)
    assert_equal(
      "??",
      @mod.encode_points(sio, [[0, 0]]).string)
    assert_equal(
      "????",
      @mod.encode_points(sio, [[0, 0], [0, 0]]).string)
    assert_equal(
      "A?",
      @mod.encode_points(sio, [[1, 0]]).string)
    assert_equal(
      "?A",
      @mod.encode_points(sio, [[0, 1]]).string)
    assert_equal(
      "AA??",
      @mod.encode_points(sio, [[1, 1], [1, 1]]).string)
    assert_equal(
      "ACACAGAOA_@",
      @mod.encode_points(sio, [[1, 2], [2, 4], [3, 8], [4, 16], [5, 32]]).string)
  end

  private

  def sio(string = nil)
    return StringIO.new(string || "")
  end
end
