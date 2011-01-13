require 'rubytracer/colour'

module Rubytracer
  module Lights
    class Ambient
      Lights.add('Ambient', self)

      def initialize value
        @value = value
      end
  
      def specular(normal, view_vector, point, scene)
        return Colour.new(0,0,0)
      end
  
      def diffuse(normal, point, scene)
        return @value
      end

      def to_hash
        ['Ambient', { :value => @value.to_hash }]
      end

      def self.from_hash hash
        colour = Colour.from_hash(hash[:value])
        Ambient.new(colour)
      end
    end
  end
end
