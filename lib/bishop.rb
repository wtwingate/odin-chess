# frozen_string_literal: true

require_relative "piece"

# This class represents the Bishop chess piece.
class Bishop < Piece
  def initialize(color, square)
    super
    @moveset = Deltas::BISHOP
  end

  def moves(board)
    @moveset.each_with_object([]) do |delta, moves|
      target_square = @square + delta
      while board.targetable_square?(target_square, @color)
        moves << target_square
        break if board.enemy_square?(target_square, @color)

        target_square += delta
      end
    end
  end

  def ascii
    @color == :white ? "B" : "b"
  end

  def unicode
    @color == :white ? "♗" : "♝"
  end
end
