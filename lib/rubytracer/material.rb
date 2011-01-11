module Rubytracer
  class Material
    def initialize(options)
      @d_colour = options[:diffuse_colour]
      @s_colour = options[:specular_colour]
      @shininess = options[:shininess]
    end

    def diffuse_colour(point, normal)
      @d_colour || Colour.new(0,0,0)
    end

    def specular_colour(point, normal)
      @s_colour || Colour.new(0,0,0)
    end

    def lit_colour(scene, normal, view_vector, point, n=0)
      reflection = Colour.new(0,0,0)

      #reflection += self.reflection(
      #reflection += self.refraction(
      
      scene.lighting.each do |light|
        reflection += self.diffuse(point, normal, scene, light)
        reflection += self.specular(point, normal, scene, view_vector, light)
      end

      return reflection
    end

    def diffuse(point, normal, scene, light)
      self.diffuse_colour(point, normal) * light.diffuse_lighting(normal, point, scene)
    end

    def specular(point, normal, scene, view_vector, light)
      if @shininess
        self.specular_colour(point, normal) * (light.specular_lighting(normal, view_vector, point, scene) ** @shininess)
      else
        Colour.new(0,0,0)
      end
    end
  end
end
