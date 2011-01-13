module Rubytracer
  class Scene
    attr_reader :lighting

    def initialize(objects=[], lighting=[])
      @objects = objects
      @lighting = lighting
    end

    def add_object(object)
      @objects << object
    end

    def add_light(light)
      @lighting << light
    end

    def intersect(ray)
      min = [nil, Float::INFINITY]
      @objects.map { |object| [object, object.intersect(ray)[0]] }.each do |object, intersection|
        min = [object, intersection] if intersection > 0 && intersection < min[1]
      end
      min
    end

    def to_hash
      { :objects => @objects.map { |o| o.to_hash }, :lighting => @lighting.map { |o| o.to_hash } }
    end

    def self.from_hash hash
      objects = hash[:objects].map { |o| Shapes.from_hash(o) }
      lighting = hash[:lighting].map { |o| Lights.from_hash(o) }
      Scene.new(objects, lighting)
    end
  end
end
