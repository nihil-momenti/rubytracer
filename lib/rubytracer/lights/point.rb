require 'geom3d'

module Rubytracer
  class PointLight
    def initialize(value, point)
      @value = value
      @point = point
    end

    def check_shadow(point, direction, distance, scene)
      ray = Geom3d::Ray.new(point + direction * 0.00001, direction)
      obj, alpha = scene.intersect(ray)
      pos = ray.pos(alpha)
      alpha < distance
    end

    def distance_loss(distance)
      ([0, 8 - distance].max / 8) ** 3
    end

    def specular(normal, view_vector, point, scene)
      vector = @point - point
      dir = vector.unit
      dis = vector.length

      if check_shadow(point, dir, dis, scene)
        Colour.new(0,0,0)
      else
        d = (2 * view_vector.dot(normal) * normal - view_vector).unit
        @value * distance_loss(dis) * [0, d.dot(dir)].max
      end
    end

    def diffuse(normal, point, scene)
      vector = @point - point
      dir = vector.unit
      dis = vector.length

      if check_shadow(point, dir, dis, scene)
        Colour.new(0,0,0)
      else
        @value * distance_loss(dis) * [0, dir.dot(normal)].max
      end
    end
  end
end
