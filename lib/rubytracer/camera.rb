module Rubytracer
  class Camera
    def initialize(view, scene)
      @view = view
      @scene = scene
    end

    def colour_of_pixel(row, col)
      ray = @view.eye_ray(row, col)
      obj, t = @scene.intersect(ray)
      if t == Float::INFINITY
        Colour.new(0.6,0.6,0.6)
      else
        pos = ray.pos(t)
        normal = obj.normal(pos)
        obj.material.lit_colour(@scene, normal, -ray.dir, pos)
      end
    end

    def to_hash
      { :view => @view.to_hash, :scene => @scene.to_hash }
    end

    def self.from_hash hash
      view = View.from_hash(hash[:view])
      scene = Scene.from_hash(hash[:scene])
    end
  end
end
