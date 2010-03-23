# coding: utf-8

module GoogleMapsPolyline
  class Decoder
    def initialize(io)
      @io = io
    end

    attr_reader :io

    def decode_points
      points = []

      until @io.eof?
        lat = read_point(@io)
        lng = read_point(@io)

        unless points.empty?
          lat += points.last[0]
          lng += points.last[1]
        end

        points << [lat, lng]
      end

      return points
    end

    def decode_levels
      levels = []

      until @io.eof?
        levels << read_level(@io)
      end

      return levels
    end

    private

    def read_point(io)
      codes = []

      while (char = io.read(1))
        code = char.unpack("C")[0] - 63
        codes << (code & ~0x20)
        break if code & 0x20 == 0
      end

      raise(ArgumentError) unless (1..6).include?(codes.size)

      bin = codes.map { |c| '%05b' % c }.reverse.join("")

      negative = (bin.slice!(-1, 1) == "1")

      num  = bin.to_i(2)
      num *= -1 if negative
      num += -1 if negative

      return num
    end

    def read_level(io)
      case io.read(1)
      when "?" then return 0
      when "@" then return 1
      when "A" then return 2
      when "B" then return 3
      else raise(ArgumentError)
      end
    end
  end
end
