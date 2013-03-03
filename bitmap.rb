require 'chunky_png'

class Bitmap
  attr_reader :height, :width, :texture_id

  @@index = {} # Index of all our textures

  private_class_method :new

  # Either use a cached texture or load a new one
  def self.load(filename)
    @@index[filename] || new(filename)
  end

  def initialize(filename)
    png = ChunkyPNG::Image.from_file(filename)

    image = png.to_rgba_stream.each_byte.to_a

    @height = png.height
    @width = png.width

    @@index[filename] = self

    @texture_id = glGenTextures(1).first
    glBindTexture GL_TEXTURE_2D, @texture_id
    glTexImage2D GL_TEXTURE_2D, 0, GL_RGBA, @width, @height, 0, GL_RGBA, GL_UNSIGNED_BYTE, image
    glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR
    glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR
  end

  def dispose
    glDeleteTextures(@texture_id)
  end

  def disposed?
    !!@texture_id
  end

end
