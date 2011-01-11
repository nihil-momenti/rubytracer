module Rubytracer
  class Scene
    def initialize objects=[], lights=[]
      @objects = objects
      @lights = lights
    end

    def add_object(object)
      @objects << object
    end

    def add_light(light)
      @lights << light
    end

    def intersect(ray)
      min = [nil, Float::INFINITY]
      @objects.map { |object| [object, object.intersect(ray)[0]] }.each do |object, intersection|
        min = [object, intersection] if intersection > 0 && intersection < min[1]
      end
      min
    end
  end
end
