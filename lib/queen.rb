# frozen_string_literal: true

# This class represents the Queen chess piece.
class Queen < Piece
  def ascii
    @color == :white ? "Q" : "q"
  end

  def unicode
    @color == :white ? "♕" : "♛"
  end
end
