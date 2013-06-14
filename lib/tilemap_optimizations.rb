Vertex = Struct.new(:x, :y, :z, :u, :v) # r g b a

class Rect

  def initialize(x, y, z, width, height)
    @x = x
    @y = y
    @z = z
    @width = width
    @height = height
  end

  def vertices
    [
    Vertex.new(@x,        @y,         @z, 0, 0),
    Vertex.new(@x,        @y+@height, @z, 0, 1),
    Vertex.new(@x+@width, @y+@height, @z, 1, 1),
    Vertex.new(@x+@width, @y,         @z, 1, 0)
    ]
  end

  def self.vertices(x, y, z, width, height)
    [
    Vertex.new(x,       y,        z, 0, 0),
    Vertex.new(x,       y+height, z, 0, 1),
    Vertex.new(x+width, y+height, z, 1, 1),
    Vertex.new(x+width, y,        z, 1, 0)
    ]
  end
end

class Tilemap

  def initialize(filename, tile_width, tile_height)
    @spritesheet = Bitmap.load(filename)

    calculate_index(tile_width, tile_height)

    @tiles = []


    @vertex_buffer = glGenBuffers(1).first

  end

  def calculate_index(tile_width, tile_height)
    row_count = @spritesheet.width / tile_width
    column_count = @spritesheet.height / tile_height 
    count = row_count * column_count

    @index = []

    count.times do |index|
      ox = index % row_count * tile_width
      oy = index/row_count * tile_height

      @index << Rect.vertices(ox, oy, 0, tile_width, tile_height)
    end

  end

  def render(index)
    #glBindTexture GL_TEXTURE_2D, @spritesheet.texture_id
    glEnableClientState(GL_VERTEX_ARRAY)

    vertices = @index[index].map{|v| [v.x, v.y]}.flatten

    glBindBuffer(GL_ARRAY_BUFFER, @vertex_buffer)
    glBufferData(GL_ARRAY_BUFFER, vertices.length, vertices.pack("f*"), GL_STATIC_DRAW)
    
    #glEnableClientState(GL_TEXTURE_COORD_ARRAY)
    glVertexPointer(2, GL_FLOAT, 0, 0)
    #glTexCoordPointer(2, GL_FLOAT, 3, 3)

    glDrawElements(GL_QUADS, 4, GL_UNSIGNED_BYTE, [0, 1, 2, 3].pack("C*"))
    glDisableClientState(GL_VERTEX_ARRAY)
    #glDisableClientState(GL_TEXTURE_COORD_ARRAY)

    glBindBuffer(GL_ARRAY_BUFFER, 0) # unbind buffer
    #vertices = []
    #@tiles.each do |tile|
    #  vertices.push << 
    #end
  end

end