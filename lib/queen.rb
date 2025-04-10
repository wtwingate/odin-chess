# frozen_string_literal: true

require_relative "piece"

# This class represents the Queen chess piece.
class Queen < Piece
  def moveset
    [0x10, 0x11, 0x01, -0x0F, -0x10, -0x11, -0x01, 0x0F]
  end

  def ascii
    @color == :white ? "Q" : "q"
  end

  def unicode
    @color == :white ? "♕" : "♛"
  end
end
