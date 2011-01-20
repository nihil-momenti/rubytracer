module Rubytracer
  class Camera
    def initialize(view, scene)
      @view = view
      @scene = scene
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
