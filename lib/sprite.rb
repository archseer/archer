require_relative 'bitmap'

class Sprite
  attr_accessor :x, :y, :z

  def initialize(filename)

    @bitmap = Bitmap.load(filename)

    @x = 0
    @y = 0
    @z = 0

    @opacity = 1.0
  end

  def opacity
    @opacity
  end

  def opacity=(val)
    raise ArgumentError, "val is not a Float!" unless val.is_a? Float
    if val < 0.0
      @opacity = 0.0
    elsif val > 1.0
      @opacity = 1.0
    else
      @opacity = val
    end
  end

  def draw # optimize to VBO (lazyfoo #16-#19)
    glLoadIdentity

    glBindTexture GL_TEXTURE_2D, @bitmap.texture_id

    glBegin GL_QUADS do
      glColor4f(1.0, 1.0, 1.0, @opacity) # set alpha opacity
      glTexCoord2f(0.0, 0.0)
      glVertex(@x, @y,  @z)
      glTexCoord2f(0.0, 1.0)
      glVertex(@x, @y+@bitmap.height,  @z)
      glTexCoord2f(1.0, 1.0)
      glVertex(@x+@bitmap.width, @y+@bitmap.height,  @z)
      glTexCoord2f(1.0, 0.0)
      glVertex(@x+@bitmap.width, @y,  @z)
    end
  end


end
