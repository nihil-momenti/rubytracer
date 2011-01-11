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
      min = [nil, INFINITY]
      @objects.map { |object| object.intersect(ray)[0] }.each do |intersection|
        min = intersection if intersection[1] > 0 && intersection[1] < min[1]
      end
      min
    end
  end
end
