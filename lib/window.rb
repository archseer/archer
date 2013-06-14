require 'opengl'
require 'glfw'

require_relative 'input'
require_relative 'fps_counter'
require_relative 'sprite'
require_relative 'tilemap'
require_relative 'gl_buffer'

include Gl, Glfw

# Note: z-index doesn't work.

glfwInit

class Window

  def initialize(title='Window', width=0, height=0)
    glfwOpenWindowHint(GLFW_WINDOW_NO_RESIZE, GL_TRUE)

    if glfwOpenWindow(width, height, 0,0,0,0, 0,0, GLFW_WINDOW ) == false
      raise "Unable to open window!"
      exit
    end

    setup

    @fps = FPS.new

    glfwSetWindowTitle(title)
    glfwEnable(GLFW_KEY_REPEAT)
    glfwSetKeyCallback(Input.method(:glfw_callback).to_proc) # hacky convert method to proc
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
    # Enable blending (alpha transparency)
    glEnable(GL_BLEND)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

    # Depth testing is useful in 3D OpenGL applications where if you render
    # something and then render something that's behind it, the object that's
    # behind won't raster it's polygons over the object that's in front because
    # the depth is tested first. The reason we disable depth testing is when you
    # mix blending and depth testing you get funky results.
    glDisable(GL_DEPTH_TEST)

    glEnable GL_TEXTURE_2D # Use 2D textures
  end

  def show
    $running = true

    close_callback = lambda do
      $running = false
      return true
    end

    glfwSetWindowCloseCallback(close_callback)

    while $running

      glfwSetWindowTitle("FPS: #{"%d.3" % @fps.calc}")

      glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
      glMatrixMode GL_MODELVIEW
      glLoadIdentity

      update

      glfwSwapBuffers
    end
  end

  def update

  end

end
