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
      return "B" if level == 3
      return "A" if level == 2
      return "@" if level == 1
      return "?"
    end
  end
end
