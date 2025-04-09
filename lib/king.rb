# frozen_string_literal: true

require_relative '../lib/piece'

# This class represents the King chess piece.
class King < Piece
  def moveset
    [+8, +9, +1, -7, -8, -9, -1, +7]
  end

  def ascii
    @color == :white ? "K" : "k"
  end

  def unicode
    @color == :white ? "♔" : "♚"
  end
end
