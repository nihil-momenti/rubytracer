%w{
  rubytracer/scene
  rubytracer/view
  rubytracer/camera
  rubytracer/colour
  rubytracer/material
  rubytracer/shapes/sphere
  rubytracer/lights/ambient
}.each do |file|
  require file
end

module RubyTracer

end 
