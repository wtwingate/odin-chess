# frozen_string_literal: true

require_relative "piece"

# This class represents the Pawn chess piece.
class Pawn < Piece
  def initialize(color, square)
    super
    @moveset = color == :white ? Deltas::W_PAWN : Deltas::B_PAWN
  end

  def moves(board)
    push(board) + double_push(board) + capture(board)
  end

  def ascii
    @color == :white ? "P" : "p"
  end

  def unicode
    @color == :white ? "♙" : "♟"
  end

  private

  def push(board)
    target = @square + @moveset[0]
    board.empty_square?(target) ? [target] : []
  end

  def double_push(board)
    return [] if moved?

    target = @square + @moveset[1]
    board.empty_square?(target) ? [target] : []
  end

  def capture(board)
    @moveset[2..].each_with_object([]) do |delta, moves|
      target = @square + delta
      moves << target if board.enemy_square?(target, @color)
    end
  end
end
