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

  private

  def sio(string = nil)
    return StringIO.new(string || "")
  end
end
