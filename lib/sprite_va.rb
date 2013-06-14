require_relative 'bitmap'

class Sprite
  attr_accessor :x, :y, :z

  def initialize(filename)

    @bitmap = Bitmap.load(filename)

    @x = 0
    @y = 0
    @z = 0

    @texcoord_buffer = glGenBuffers(1).first
    glBindBuffer(GL_ARRAY_BUFFER, @texcoord_buffer)

    @tex_coords = [
      0.0, 0.0,
      0.0, 1.0,
      1.0, 1.0,
      1.0, 0.0
    ]

    glBufferData(GL_ARRAY_BUFFER, @tex_coords.length, @tex_coords.pack("f*"), GL_STATIC_DRAW)

    glBindBuffer(GL_ARRAY_BUFFER, 0) # unbind buffer

    @coords = [
      @x, @y,  @z, 
      @x, @y+@bitmap.height,  @z,
      @x+@bitmap.width, @y+@bitmap.height,  @z,
      @x+@bitmap.width, @y,  @z
    ].pack("f*")


    @off = [0, 1, 2, 3].pack("C*")

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
    glBindTexture GL_TEXTURE_2D, @bitmap.texture_id

    glBindBuffer(GL_ARRAY_BUFFER, 0) # unbind buffer
    
    glVertexPointer(3, GL_FLOAT, 0, @coords)

    glBindBuffer(GL_ARRAY_BUFFER, @texcoord_buffer)
    glTexCoordPointer(2, GL_FLOAT, 0, 0)
    

    #glTexCoordPointer(2, GL_FLOAT, 0, @tex_coords)


    glDrawElements(GL_QUADS, 4, GL_UNSIGNED_BYTE, @off)

    #glBegin GL_QUADS do
    #  glColor4f(1.0, 1.0, 1.0, @opacity) # set alpha opacity
    #end
  end


end
