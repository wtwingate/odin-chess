# frozen_string_literal: true

# This class represents the Bishop chess piece.
class Bishop < Piece
  def ascii
    @color == :white ? "B" : "b"
  end

  def unicode
    @color == :white ? "♗" : "♝"
  end
end
