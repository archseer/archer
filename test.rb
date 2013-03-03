require_relative 'lib/window'

class Window_Test < Window

  def initialize(title='Window', width=0, height=0)
    super(title, width, height)

    @sprite = Sprite.new('obama_sprite.png')
    @sprites = []
    2000.times do
      @sprites << Sprite.new('crate.png')
    end

    keyfun = lambda do |key,action|
      if action != GLFW_PRESS
        next
      end

      puts key

      case key
      when GLFW_KEY_UP
        @sprite.y -= 4
      when GLFW_KEY_DOWN
        @sprite.y += 4
      when GLFW_KEY_LEFT
        @sprite.x -= 4
      when GLFW_KEY_RIGHT
        @sprite.x += 4
      when 81
        @sprite.opacity -= 0.1
      when 87
        @sprite.opacity += 0.1
      end

    end
    glfwSetKeyCallback( keyfun )
  end

  def update

    @sprites.each do |sprite|
      sprite.draw
    end
    @sprite.draw
  end

end

@window = Window_Test.new
@window.show
