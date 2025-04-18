# frozen_string_literal: true

require_relative "piece"

# This class represents the Queen chess piece.
class Rook < Piece
  def initialize(color, square)
    super
    @moveset = Deltas::ROOK
  end

  def ascii
    @color == :white ? "R" : "r"
  end

  def unicode
    @color == :white ? "♖" : "♜"
  end
end
