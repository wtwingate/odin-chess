# frozen_string_literal: true

# This class represents the Queen chess piece.
class Queen < Piece
  def moveset
    [+8, +9, +1, -7, -8, -9, -1, +7]
  end

  def ascii
    @color == :white ? "Q" : "q"
  end

  def unicode
    @color == :white ? "♕" : "♛"
  end
end
