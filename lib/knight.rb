# frozen_string_literal: true

# This class represents the Knight chess piece.
class Knight < Piece
  def ascii
    @color == :white ? "N" : "n"
  end

  def unicode
    @color == :white ? "♘" : "♞"
  end
end
