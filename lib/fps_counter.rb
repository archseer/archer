
class FPS
  def initialize(interval = 1.0)
    @interval = interval

    @frame_count = 0
    @fps = 0.0

    @initial_time = glfwGetTime
  end

  def calc
    @current_time = glfwGetTime

    if @current_time - @initial_time > @interval
      @fps = @frame_count / (@current_time - @initial_time)

      @frame_count = 0
      @initial_time = glfwGetTime
    else
      @frame_count += 1
    end

    return @fps
  end
end
