# frozen_string_literal: true

# This class implements algorithms for calculating all the pseudo-legal
# moves available to each Chess piece given the current board state.
class MoveGenerator
  def initialize(board)
    @board = board
  end

  def pseudo_legal_moves
    moves = {}

    @board.squares.each_with_index do |square, index|
      next unless on_the_board?(index) && square

      moves[index] = calculate_moves(square, index)
    end

    moves
  end

  def calculate_moves(piece, index)
    case piece
    when Queen, Rook, Bishop
      sliding_moves(piece, index)
    when King, Knight
      non_sliding_moves(piece, index)
    when Pawn
      pawn_moves(piece, index)
    end
  end

  def sliding_moves(piece, index)
    piece.moveset.each_with_object([]) do |delta, next_indexes|
      next_index = index + delta
      while on_the_board?(next_index) && can_target?(piece, next_index)
        next_indexes << next_index
        next_index += delta
      end
    end
  end

  def non_sliding_moves(piece, index)
    next_indexes = piece.moveset.map { |delta| index + delta }
    next_indexes.select do |next_index|
      on_the_board?(next_index) && can_target?(piece, next_index)
    end
  end

  def pawn_moves(piece, position)
    # TODO
  end

  private

  # Using an array with 128 indexes enables this clever little method
  # to check for out-of-bounds indexes. For more information, check out
  # https://www.chessprogramming.org/0x88
  def on_the_board?(index)
    index.nobits?(0x88)
  end

  def can_target?(piece, index)
    target = @board.squares[index]
    return true if target.nil?

    target.color != piece.color
  end
end
