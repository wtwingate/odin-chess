# frozen_string_literal: true

require_relative "piece"

# This class represents the Pawn chess piece.
class Pawn < Piece
  def initialize(color, square)
    super
    @moveset = color == :white ? Deltas::W_PAWN : Deltas::B_PAWN
  end

  def ascii
    @color == :white ? "P" : "p"
  end

  def unicode
    @color == :white ? "♙" : "♟"
  end
end
