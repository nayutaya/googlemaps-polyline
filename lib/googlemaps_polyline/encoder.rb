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
        self.write_num(lat - plat)
        self.write_num(lng - plng)
        plat, plng = lat, lng
      }

      return @io
    end
    
    def write_num(num)
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

      @io.write(codes.pack("C*"))

      return @io
    end
  end
end
