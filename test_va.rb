require_relative 'lib/window'

require_relative 'lib/sprite_va' # needs sprite_va instead of sprite

class Window_Test < Window

  def initialize(title='Window', width=0, height=0)
    super(title, width, height)

    glEnableClientState(GL_VERTEX_ARRAY)
    glEnableClientState(GL_TEXTURE_COORD_ARRAY)

    @sprite = Sprite.new('obama_sprite.png')
    @sprites = []
    2000.times do
      @sprites << Sprite.new('crate.png')
    end
  end

  def update
    @sprite.y -= 4 if Input.pressed? GLFW_KEY_UP
    @sprite.y += 4 if Input.pressed? GLFW_KEY_DOWN
    @sprite.x -= 4 if Input.pressed? GLFW_KEY_LEFT
    @sprite.x += 4 if Input.pressed? GLFW_KEY_RIGHT

    @sprite.opacity -= 0.1 if Input.pressed? 'Q'
    @sprite.opacity += 0.1 if Input.pressed? 'W'

    @sprites.each do |sprite|
      sprite.draw
    end
    @sprite.draw
  end

end

@window = Window_Test.new
@window.show
