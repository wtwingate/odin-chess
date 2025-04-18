# frozen_string_literal: true

require_relative "piece"

# This class represents the Queen chess piece.
class Rook < Piece
  def initialize(color, square)
    super
    @moveset = Deltas::ROOK
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
    @color == :white ? "R" : "r"
  end

  def unicode
    @color == :white ? "♖" : "♜"
  end
end
