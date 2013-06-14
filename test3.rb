require_relative 'lib/window'

# NOTE: Requires a few seconds to load the 960x960 PNG...
class Window_Test < Window

  def initialize(title='Window', width=0, height=0)
    super(title, width, height)
    @tilemap = Tilemap.new('hyptosis_tile-art-batch-1.png', 32, 32)
  end

  def update # no problems with rendering 900 tiles or even 2-3 times that, and without optimization.
    for i in 0..900
      @tilemap.render(i,i,i)
    end
  end

end

@window = Window_Test.new
@window.show
