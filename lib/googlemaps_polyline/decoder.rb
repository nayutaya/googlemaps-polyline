# coding: utf-8

module GoogleMapsPolyline
  class Decoder
    def initialize(io)
      @io = io
    end

    attr_reader :io

    def self.decode_polyline(io)
      polylines = []

      until io.eof?
        lat = self.read_fragment(io)
        lng = self.read_fragment(io)

        unless polylines.empty?
          lat += polylines.last[0]
          lng += polylines.last[1]
        end

        polylines << [lat, lng]
      end

      return polylines
    end

    def self.read_fragment(io)
      buffer = []

      while (char = io.read(1))
        code = char.unpack("C")[0] - 63
        buffer << (code & ~0x20)
        break if code & 0x20 == 0
      end

      raise(ArgumentError) unless (1..6).include?(buffer.size)

      bin = buffer.map { |code| '%05b' % code }.reverse.join("")

      negative = (bin.slice!(-1, 1) == "1")

      num  = bin.to_i(2)
      num *= -1 if negative
      num += -1 if negative

      return num
    end

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
