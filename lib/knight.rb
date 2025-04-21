# frozen_string_literal: true

require_relative "piece"

# This class represents the Knight chess piece.
class Knight < Piece
  def initialize(color, square)
    super
    @moveset = Deltas::KNIGHT
  end

  def moves(board)
    @moveset.each_with_object([]) do |delta, moves|
      target = @square + delta
      next unless board.targetable_square?(target, @color)

      moves << target
    end
  end

  def ascii
    @color == :white ? "N" : "n"
  end

  def unicode
    @color == :white ? "♘" : "♞"
  end
end
