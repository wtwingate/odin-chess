# frozen_string_literal: true

require_relative "piece"

# This class represents the Bishop chess piece.
class Bishop < Piece
  def initialize(color, square)
    super
    @moveset = Deltas::BISHOP
  end

  def ascii
    @color == :white ? "B" : "b"
  end

  def unicode
    @color == :white ? "♗" : "♝"
  end
end
