require 'geom3d'

module Rubytracer
  class View
    def initialize(view_point, look_at_point, view_up, h_fov, height, width, multi)
      view_direction = (look_at_point - view_point).unit
      view_up = view_up - view_direction * view_up.dot(view_direction)
      spacing = 2 * Math.tan(h_fov * Math.pi / 360) / width

      @point = view_point
      @multi = multi
      @y_vector = -spacing * view_up.unit
      @x_vector = spacing * view_up.unit.cross(view_direction.unit).unit
      @top_left = (view_point + view_direction) - (@y_vector * height / 2  + @x_vector * width / 2)
    end

    def eye_ray(row, col)
      dy = @y_vector * (row + 0.5)
      dx = @x_vector * (col + 0.5)
      point = @top_left + dy + dx
      Geom3d::Ray.new(@point, point - @point)
    end
  end
end   
