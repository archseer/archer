require_relative 'bitmap'

class Sprite
  attr_accessor :x, :y, :z
  
  def initialize(filename)

    @bitmap = Bitmap.load(filename)

    @x = 0
    @y = 0
    @z = 0

  end

  def draw # optimize to VBO (lazyfoo #16-#20)
    glLoadIdentity

    glBindTexture GL_TEXTURE_2D, @bitmap.texture_id

    glBegin GL_QUADS do
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