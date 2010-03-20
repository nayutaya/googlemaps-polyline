# coding: utf-8

module GoogleMapsPolyline
  class Encoder
    def initialize(io)
      @io = io
    end

    attr_reader :io

    def encode_points(points)
      plat, plng = 0, 0
      points.each { |lat, lng|
        @io.write(pack_point(lat - plat))
        @io.write(pack_point(lng - plng))
        plat, plng = lat, lng
      }

      return @io
    end

    def encode_levels(levels)
      levels.each { |level|
        @io.write(pack_level(level))
      }

      return @io
    end

    private

    def pack_point(num)
      negative = (num < 0)
      if negative
        num -= -1
        num *= -1
      end

      num <<= 1
      num  |= 1 if negative

      codes = []

      begin
        code = (num & 0b11111) + 63
        num >>= 5
        code += 0x20 if num > 0
        codes << code
      end while num > 0

      return codes.pack("C*")
    end

    def pack_level(level)
      case level
      when 0 then return "?"
      when 1 then return "@"
      when 2 then return "A"
      when 3 then return "B"
      else raise(ArgumentError)
      end
    end
  end
end
