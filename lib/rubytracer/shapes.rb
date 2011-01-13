module Rubytracer
  module Shapes
    def self.add name, klass
      (@klasses ||= {})[name] = klass
    end

    def self.[] name
      (@klasses ||= {})[name]
    end

    def self.from_hash hash
      name, o = hash
      self[name].from_hash(o)
    end
  end
end

%w{
  rubytracer/shapes/sphere
}.each do |file|
  require file
end
