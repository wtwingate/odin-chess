# frozen_string_literal: true

require_relative "piece"

# This class represents the Queen chess piece.
class Rook < Piece
  def moveset
    [0x10, 0x01, -0x10, -0x01]
  end

  def ascii
    @color == :white ? "R" : "r"
  end

  def unicode
    @color == :white ? "♖" : "♜"
  end
end
