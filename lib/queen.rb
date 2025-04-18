# frozen_string_literal: true

require_relative "piece"

# This class represents the Queen chess piece.
class Queen < Piece
  def initialize(color, square)
    super
    @moveset = Deltas::QUEEN
  end

  def ascii
    @color == :white ? "Q" : "q"
  end

  def unicode
    @color == :white ? "♕" : "♛"
  end
end
