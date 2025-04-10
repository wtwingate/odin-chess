# frozen_string_literal: true

require_relative "piece"

# This class represents the Knight chess piece.
class Knight < Piece
  def moveset
    [0x21, 0x12, -0x0E, -0x1F, -0x21, -0x12, 0x0E, 0x1F]
  end

  def ascii
    @color == :white ? "N" : "n"
  end

  def unicode
    @color == :white ? "♘" : "♞"
  end
end
