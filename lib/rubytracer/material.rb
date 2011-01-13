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
      self.diffuse_colour(point, normal) * light.diffuse(normal, point, scene)
    end

    def specular(point, normal, scene, view_vector, light)
      if @shininess
        self.specular_colour(point, normal) * (light.specular(normal, view_vector, point, scene) ** @shininess)
      else
        Colour.new(0,0,0)
      end
    end

    def to_hash
      { :d_colour => @d_colour.to_hash , :s_colour => @s_colour.to_hash, :shininess => @shininess }
    end

    def self.from_hash hash
      d_colour = Colour.from_hash(hash[:d_colour])
      s_colour = Colour.from_hash(hash[:s_colour])
      Material.new(:diffuse_colour => d_colour, :specular_colour => s_colour, :shininess => hash[:shininess])
    end
  end
end
