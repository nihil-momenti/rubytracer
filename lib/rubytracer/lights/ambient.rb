require 'rubytracer/colour'

module Rubytracer
  class AmbientLight
    def initialize value
      @value = value
    end

    def specular(normal, view_vector, point, scene)
      return Colour.new(0,0,0)
    end

    def diffuse(normal, point, scene)
      return @value
    end
  end
end
