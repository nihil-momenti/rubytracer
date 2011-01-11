module Rubytracer
  class Sphere
    def initialize(center, radius, material)
      @center = center
      @radius = radius
      @material = material
    end

    def normal(point)
      (point - @center).unit
    end

    def intersect(ray)
      q = @center - ray.start
      v_dot_q = ray.dir.dot(q)
      square_diffs = q.dot(q) - @radius ** 2
      discrim = v_dot_q ** 2 - square_diffs
      if discrim >= 0
        root = Math.sqrt(discrim)
        t0 = v_dot_q - root
        t1 = v_dot_q + root
        [t0, t1]
      else
        [Float::INFINITY, -Float::INFINITY] # May not be portable
      end
    end
  end
end
