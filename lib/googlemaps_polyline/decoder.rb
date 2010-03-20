# coding: utf-8

module GoogleMapsPolyline
  class Decoder
    def initialize(io)
      @io = io
    end

    attr_reader :io
  end
end
