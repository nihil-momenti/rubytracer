require 'geom3d'

module Rubytracer
  class View
    attr_reader :height, :width

    def initialize(point, multi, y_vector, x_vector, top_left, height, width, scene)
      @point = point
      @multi = multi
      @y_vector = y_vector
      @x_vector = x_vector
      @top_left = top_left
      @height = height
      @width = width
      @scene = scene
    end

    def self.create(view_point, look_at_point, view_up, h_fov, height, width, multi, scene)
      view_direction = (look_at_point - view_point).unit
      view_up = view_up - view_direction * view_up.dot(view_direction)
      spacing = 2 * Math.tan(h_fov * Math::PI / 360) / width
      
      point = view_point
      multi = multi
      y_vector = -spacing * view_up.unit
      x_vector = spacing * view_up.unit.cross(view_direction.unit).unit
      top_left = (view_point + view_direction) - (y_vector * height / 2  + x_vector * width / 2)
      View.new(point, multi, y_vector, x_vector, top_left, height, width, scene)
    end


    def eye_ray(row, col)
      dy = @y_vector * (row + 0.5)
      dx = @x_vector * (col + 0.5)
      point = @top_left + dy + dx
      Geom3d::Ray.new(@point, point - @point)
    end

    def colour_of_row(row)
      (0...@width).map { |col| colour_of_pixel(row, col) }
    end

    def colour_of_pixel(row, col)
      obj, t = @scene.intersect eye_ray(row, col)
      if t == Float::INFINITY
        Colour.new(0.6,0.6,0.6)
      else
        pos = ray.pos(t)
        normal = obj.normal(pos)
        obj.material.lit_colour(@scene, normal, -ray.dir, pos)
      end
    end

    def to_hash 
      { :point => @point.to_hash, :multi => @multi, :y_vector => @y_vector.to_hash, :x_vector => @x_vector.to_hash, :top_left => @top_left.to_hash }
    end

    def self.from_hash hash
      point = Geom3d::Point.from_hash(hash[:point])
      y_vector = Geom3d::Vector.from_hash(hash[:y_vector])
      x_vector = Geom3d::Vector.from_hash(hash[:x_vector])
      top_left = Geom3d::Point.from_hash(hash[:top_left])
      View.new(point, hash[:multi], y_vector, x_vector, top_left)
    end
  end
end   
