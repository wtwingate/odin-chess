# frozen_string_literal: true

# This class represents the Pawn chess piece.
class Pawn < Piece
  def ascii
    @color == :white ? "P" : "p"
  end

  def unicode
    @color == :white ? "♙" : "♟"
  end
end
