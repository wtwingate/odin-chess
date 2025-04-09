# frozen_string_literal: true

# This is the base class for the various chess pieces.
class Piece
  attr_reader :color, :moved
  
  def initialize(color)
    @color = color
    @moved = false
  end
end
