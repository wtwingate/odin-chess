# frozen_string_literal: true

# This class represents the King chess piece.
class King < Piece
  def ascii
    @color == :white ? "K" : "k"
  end

  def unicode
    @color == :white ? "♔" : "♚"
  end
end
