# coding: utf-8

require "googlemaps_polyline/encoder"

module GoogleMapsPolyline
  def self.encode_polyline_1e5(records)
    points = []
    levels = []
    records.each { |lat, lng, level|
      points << [lat, lng]
      levels << level
    }

    encoded_points = Encoder.new(StringIO.new).encode_points(points).string
    encoded_levels = Encoder.new(StringIO.new).encode_levels(levels).string

    return encoded_points, encoded_levels
  end
end
