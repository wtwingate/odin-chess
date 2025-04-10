# frozen_string_literal: true

require_relative "piece"

# This class represents the Bishop chess piece.
class Bishop < Piece
  def moveset
    [0x11, -0x0F, -0x11, 0x0F]
  end

  def ascii
    @color == :white ? "B" : "b"
  end

  def unicode
    @color == :white ? "♗" : "♝"
  end
end
