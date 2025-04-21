# frozen_string_literal: true

require_relative "piece"

# This class represents the King chess piece.
class King < Piece
  def initialize(color, square)
    super
    @moveset = Deltas::KING
  end

  def in_check?(board)
    enemy_color = @color == :white ? :black : :white
    enemy_pieces = board.pieces(enemy_color)
    enemy_pieces.any? { |piece| piece.moves(board).include?(square) }
  end

  def moves(board)
    @moveset.each_with_object([]) do |delta, moves|
      target = @square + delta
      next unless board.targetable_square?(target, @color)

      moves << target
    end
  end

  def ascii
    @color == :white ? "K" : "k"
  end

  def unicode
    @color == :white ? "♔" : "♚"
  end
end
