# frozen_string_literal: true

# This class represents the Queen chess piece.
class Rook < Piece
  def ascii
    @color == :white ? "R" : "r"
  end

  def unicode
    @color == :white ? "♖" : "♜"
  end
end
