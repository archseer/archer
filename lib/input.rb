# press?(sym) → true or false
#   Determines whether the button that corresponds to the symbol sym is currently being pressed.
#   If the button is being pressed, returns TRUE. If not, returns FALSE.
# repeat?(sym) → true or false
#   Determines whether the button that corresponds to the symbol sym is being pressed again. Unlike trigger?, takes into account the repeat input of a button being held down continuously. If the button is being pressed, returns TRUE. If not, returns FALSE.
# trigger?(sym) → true or false
#  Determines whether the button that corresponds to the symbol sym is being pressed again. “Pressed again” is seen as time having passed between the button being not pressed and being pressed. If the button is being pressed, returns TRUE. If not, returns FALSE.

module Input
  @@keys = {}

  def self.pressed? key
    key = key.bytes.first if key.is_a?(String) # convert a char representation to bytes
    @@keys[key] == :pressed
  end

  def self.glfw_callback key, action
    if action == GLFW_PRESS
      @@keys[key] = :pressed
    else
      @@keys[key] = :released
    end

  end

end