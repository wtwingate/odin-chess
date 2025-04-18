# frozen_string_literal: true

require_relative "piece"

# This class represents the King chess piece.
class King < Piece
  def initialize(color, square)
    super
    @moveset = Deltas::KING
  end

  def ascii
    @color == :white ? "K" : "k"
  end

  def unicode
    @color == :white ? "♔" : "♚"
  end
end
