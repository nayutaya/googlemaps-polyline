# coding: utf-8

require "test_helper"
require "googlemaps_polyline/core"

class CoreTest < Test::Unit::TestCase
  def setup
    @mod = GoogleMapsPolyline
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
end
