# frozen_string_literal: true

# This class represents the Knight chess piece.
class Knight < Piece
  def moveset
    [+17, +10, -6, -15, -17, -10, +6, +15]
  end

  def ascii
    @color == :white ? "N" : "n"
  end

  def unicode
    @color == :white ? "♘" : "♞"
  end
end
