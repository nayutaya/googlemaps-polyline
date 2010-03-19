# coding: utf-8

require "test_helper"
require "googlemaps_polyline/encoder"
require "stringio"

class EncoderTest < Test::Unit::TestCase
  def setup
    @mod = GoogleMapsPolyline::Encoder
  end

  def test_write_num
    assert_equal("?"     , @mod.write_num(sio,         0))
    assert_equal("A"     , @mod.write_num(sio,         1))
    assert_equal("@"     , @mod.write_num(sio,        -1))
    assert_equal("{sopV" , @mod.write_num(sio,  12345678))
    assert_equal("zsopV" , @mod.write_num(sio, -12345678))
    assert_equal("?gsia@", @mod.write_num(sio,  18000000))
    assert_equal("~fsia@", @mod.write_num(sio, -18000000))
  end

=begin
  def test_encode_points
    assert_equal(
      "??",
      @mod.decode_polyline(sio, [[0, 0]]).string)
  end
=end

  private

  def sio(string = nil)
    return StringIO.new(string || "")
  end
end
