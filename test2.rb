#glVertexPointer(3,GL_FLOAT,0,$helix_v.flatten.pack("f*"))

require_relative 'lib/window'

class Window_Test < Window

  def initialize(title='Window', width=0, height=0)
    super(title, width, height)

    glEnableClientState(GL_VERTEX_ARRAY)
    @va = [
      0, 0, 0,
     0, 100, 0,
     100, 100, 0,
     100, 0, 0
     ].pack("f*")

    #@buffer = glGenBuffers(1).first
    #glBindBuffer(GL_ARRAY_BUFFER, @buffer)
    #glBufferData(GL_ARRAY_BUFFER, 6*4, @va, GL_DYNAMIC_DRAW)
    
    #glDisable(GL_BLEND)
  end

  def update

    glVertexPointer(3, GL_FLOAT, 0, @va)

    glDrawElements(GL_QUADS, 4, GL_UNSIGNED_BYTE, [0, 1, 2, 3].pack("C*"))
  end

end

@window = Window_Test.new
@window.show
