require 'opengl'
require 'glfw'

require_relative 'sprite'
require_relative 'gl_buffer'

include Gl,Glfw

# Note: z-index doesn't work.

glfwInit

class Window

  def initialize(title='Window', width=0, height=0)
    if glfwOpenWindow(width, height, 0,0,0,0, 0,0, GLFW_WINDOW ) == false
      raise "Unable to open window!"
      exit
    end

    setup

    @sprite = Sprite.new('crate.png')
    @sprites = []
    2000.times do
      @sprites << Sprite.new('crate.png')
    end

    glfwSetWindowTitle(title)

    @start_time = glfwGetTime

    keyfun = lambda do |key,action|
      if action != GLFW_PRESS
        next
      end

      case key
      when GLFW_KEY_UP
        @sprite.y -= 4
      when GLFW_KEY_DOWN
        @sprite.y += 4
      when GLFW_KEY_LEFT
        @sprite.x -= 4
      when GLFW_KEY_RIGHT
        @sprite.x += 4
      end

    end
    glfwSetKeyCallback( keyfun )
    glfwEnable(GLFW_KEY_REPEAT)

    #glfwSwapInterval(0)
  end

  def setup
    viewport = glGetIntegerv(GL_VIEWPORT)

    glMatrixMode(GL_PROJECTION)
    glPushMatrix()
    glLoadIdentity()
    glOrtho(0, viewport[2], viewport[3], 0, 0, 1) # This sets up the OpenGL window so that (0,0) corresponds to the top left corner, and (640,480) corresponds to the bottom right hand corner.
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()
    glTranslatef(0.375, 0.375, 0.0) # http://www.opengl.org/archives/resources/faq/technical/transformations.htm#tran0030

    glDepthFunc GL_LEQUAL

    glDisable(GL_LIGHTING)
    # Disable dithering
    glDisable(GL_DITHER)
    # Disable blending (for now)
    glDisable(GL_BLEND)

    glEnable GL_TEXTURE_2D # Use 2D textures
  end

  def show
    $running = true

    close_callback = lambda do
      $running = false
      return true
    end

    glfwSetWindowCloseCallback(close_callback)

    frame_count = 0

    while $running

      current_time = glfwGetTime

      #Calculate and display FPS (frames per second)
      if (current_time - @start_time) > 1
        frame_rate = frame_count / (current_time - @start_time);
        glfwSetWindowTitle "Spinning Triangle #{"%d.3" % frame_rate} FPS)"
        @start_time = current_time

        frame_count = 0
      else
        frame_count = frame_count + 1
      end

      glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
      glMatrixMode GL_MODELVIEW
      glLoadIdentity

      @sprite.draw
      @sprites.each do |sprite|
        sprite.draw
      end

      glfwSwapBuffers
      #sleep 0.01  # to avoid consuming all CPU power
    end
  end

  def update

  end

end

@window = Window.new
@window.show