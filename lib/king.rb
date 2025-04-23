# frozen_string_literal: true

require_relative "piece"

# This class represents the King chess piece.
class King < Piece
  def initialize(color, square)
    super
    @moveset = Deltas::KING
  end

  def in_check?(board)
    board.targeted_square?(@square, @color)
  end

  def moves(board)
    moves = []

    @moveset.each do |delta|
      target = @square + delta
      next unless board.targetable_square?(target, @color)

      moves << target
    end

    moves + castling_moves(board)
  end

  def castling_moves(board)
    return [] if moved?

    ally_rooks = board.get_rooks(@color)

    ally_rooks.each_with_object([]) do |rook, moves|
      next if rook.moved?
      next unless board.empty_squares_between?(@square, rook.square)

      shift = @square < rook.square ? 0x02 : -0x02
      moves << (@square + shift)
    end
  end

  def ascii
    @color == :white ? "K" : "k"
  end

  def unicode
    @color == :white ? "♔" : "♚"
  end

  private

  def empty_squares_between?(rook); end
end
