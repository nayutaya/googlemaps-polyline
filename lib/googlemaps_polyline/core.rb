# coding: utf-8

require "googlemaps_polyline/encoder"
require "googlemaps_polyline/decoder"

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

  def self.decode_polyline_1e5(points, levels)
    decoded_points = Decoder.new(StringIO.new(points)).decode_points
    decoded_levels = Decoder.new(StringIO.new(levels)).decode_levels
    return decoded_points.zip(decoded_levels).map { |a| a.flatten }
  end
end
