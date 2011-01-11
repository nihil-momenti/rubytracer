module Rubytracer
  class Colour
    attr_reader :r, :g, :b

    def initialize(r,g,b)
      @r = r
      @g = g
      @b = b
    end

    def - other
      Colour.new(@r - other.r, @g - other.g, @b - other.b)
    end

    def + other
      Colour.new(@r + other.r, @g + other.g, @b + other.b)
    end

    def * scale
      Colour.new(@r * scale, @g * scale, @b * scale)
    end

    def ** power
      Colour.new(@r ** power, @g ** power, @b ** power)
    end

    def / scale
      self * (1.0/scale)
    end

    def +@
      self
    end

    def -@
      Colour.new(-@r, -@g, -@b)
    end

    def to_int
      [[[0, @r * 256].max, 255].min, [[0, @g * 256].max, 255].min, [[0, @b * 256].max, 255].min]
    end
  end
end


class Fixnum
  alias :times_without_rubytracer :'*'

  def * other
    case other
    when Rubytracer::Colour
      Rubytracer::Colour.new(self * other.r, self * other.g, self * other.b)
    else
      self.times_without_rubytracer(other)
    end
  end
end

class Bignum
  alias :times_without_rubytracer :'*'

  def * other
    case other
    when Rubytracer::Colour
      Rubytracer::Colour.new(self * other.r, self * other.g, self * other.b)
    else
      self.times_without_rubytracer(other)
    end
  end
end

class Float
  alias :times_without_rubytracer :'*'

  def * other
    case other
    when Rubytracer::Colour
      Rubytracer::Colour.new(self * other.r, self * other.g, self * other.b)
    else
      self.times_without_rubytracer(other)
    end
  end
end
