class Tilemap
  attr_reader :tile_width, :tile_height
  attr_reader :tiles_per_row, :tiles_per_column

  def initialize(filename, tile_width, tile_height)
    @spritesheet = Bitmap.load(filename)

    @tile_width = tile_width
    @tile_height = tile_height

    @tiles_per_row = @spritesheet.width/@tile_width
    @tiles_per_column = @spritesheet.height/@tile_height
  end

  def render(index, x=0, y=0, z=0, opacity=1.0)
    # need to convert to percentage, as we use a range from 0.0 to 1.0 on glTexCoord
    ox = (index % @tiles_per_row ).to_f / @tiles_per_row.to_f
    oy = (index/@tiles_per_row).to_f / @tiles_per_column.to_f

    wx = (index % @tiles_per_row + 1).to_f / @tiles_per_row.to_f  # we need to add 1, as we're interested in the lower-right corner, not upper left
    wy = (index/@tiles_per_row + 1).to_f / @tiles_per_column.to_f

    glBegin GL_QUADS do
      glColor4f(1.0, 1.0, 1.0, opacity) # set alpha opacity
      glTexCoord2f(ox, oy)
      glVertex(x, y,  z)
      glTexCoord2f(ox, wy)
      glVertex(x, y+@tile_height,  z)
      glTexCoord2f(wx, wy)
      glVertex(x+@tile_width, y+@tile_height,  z)
      glTexCoord2f(wx, oy)
      glVertex(x+@tile_width, y,  z)
    end
  end
end