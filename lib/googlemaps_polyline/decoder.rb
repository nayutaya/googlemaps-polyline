# coding: utf-8

module GoogleMapsPolyline
  class Decoder
    def initialize(io)
      @io = io
    end

    attr_reader :io

    def decode_levels
      levels = []

      while (char = @io.read(1))
        levels << unpack_level(char)
      end

      return levels
    end

    def unpack_level(char)
      case char
      when "?" then return 0
      when "@" then return 1
      when "A" then return 2
      when "B" then return 3
      else raise(ArgumentError)
      end
    end
  end
end
