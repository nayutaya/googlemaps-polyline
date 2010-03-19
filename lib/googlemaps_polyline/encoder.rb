# coding: utf-8

module GoogleMapsPolyline
  module Encoder

    def self.write_num(io, num)
p num
      p negative = (num < 0)
      if negative
        num -= -1
        num *= -1
      end
p num

      num <<= 1
      num  |= 1 if negative
p num.to_s(2)

      codes = []

      begin
p num
        code = (num & 0b11111) + 63
        num >>= 5
        code |= 0x20 if num > 0 #num <= 0b11111
        codes << code
p codes
      end while num > 0
p codes.map { |x| x.to_s(2) }

      return codes.pack("C*")
    end

=begin
    def self.encode_points(io, points)
    end
=end
  end
end
