class Buffer
  attr_reader :id

  def initialize(id=nil)
    @id = id || glGenBuffers(1).first
  end

  def write *array
    return if array.empty?

    glBindBuffer(GL_ARRAY_BUFFER_ARB, @id)
    glBufferData(GL_ARRAY_BUFFER, array.length, array.pack("C*"), GL_STATIC_DRAW)
  end
end
