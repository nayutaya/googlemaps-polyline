# coding: utf-8

require "test_helper"
require "googlemaps_polyline/core"

class CoreTest < Test::Unit::TestCase
  def setup
    @mod = GoogleMapsPolyline
  end

  def test_encode_points_and_levels
    points, levels = @mod.encode_points_and_levels([[0, 0]], [3])
    assert_equal("??", points)
    assert_equal("B",  levels)
  end

  def test_encode_polyline_1e5__1
    points, levels = @mod.encode_polyline_1e5([[0, 0, 3]])
    assert_equal("??", points)
    assert_equal("B",  levels)
  end

  def test_encode_polyline_1e5__1
    points, levels = @mod.encode_polyline_1e5(
      [[1, 2, 3], [2, 4, 2], [3, 8, 1], [4, 16, 0], [5, 32, 3]])
    assert_equal("ACACAGAOA_@", points)
    assert_equal("BA@?B",       levels)
  end

  def test_decode_points_and_levels
    expected = [[[0, 0]], [3]]
    assert_equal(
      expected,
      @mod.decode_points_and_levels("??", "B"))
  end

  def test_decode_polyline_1e5__1
    expected = [[0, 0, 3]]
    assert_equal(
      expected,
      @mod.decode_polyline_1e5("??", "B"))
  end

  def test_decode_polyline_1e5__2
    expected = [[1, 2, 3], [2, 4, 2], [3, 8, 1], [4, 16, 0], [5, 32, 3]]
    assert_equal(
      expected,
      @mod.decode_polyline_1e5("ACACAGAOA_@", "BA@?B"))
  end

=begin
  def test_encode_and_decode
    srand(0)
    points = 20.times.map { [rand * 180 - 90, rand * 360 - 180] }
    levels = [3] + 18.times.map { rand(4) } + [3]
  end
=end
end
