# frozen_string_literal: true

require_relative "piece"

# This class represents the Pawn chess piece.
class Pawn < Piece
  def initialize(color, square)
    super
    @moveset = color == :white ? Deltas::W_PAWN : Deltas::B_PAWN
  end

  def moves(board)
    push(board) + capture(board)
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
    return [] unless board.empty_square?(target)

    moved? ? [target] : [target] + double_push(board)
  end

  def double_push(board)
    target = @square + @moveset[1]
    return [] unless board.empty_square?(target)

    [target]
  end

  def capture(board)
    @moveset[2..].each_with_object([]) do |delta, moves|
      target = @square + delta
      if board.enemy_square?(target, @color) || board.en_passant_square?(target)
        moves << target
      end
    end
  end
end
