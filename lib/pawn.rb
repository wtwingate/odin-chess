# frozen_string_literal: true

require_relative "piece"

# This class represents the Pawn chess piece.
class Pawn < Piece
  def moveset
    @color == :white ? [0x10] : [-0x10]
  end

  def ascii
    @color == :white ? "P" : "p"
  end

  def unicode
    @color == :white ? "♙" : "♟"
  end
end
