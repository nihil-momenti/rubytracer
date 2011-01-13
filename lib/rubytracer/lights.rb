module Rubytracer
  module Lights
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
  rubytracer/lights/ambient
  rubytracer/lights/point
}.each do |file|
  require file
end
