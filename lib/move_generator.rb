# frozen_string_literal: true

# This class implements algorithms for calculating all the pseudo-legal
# moves available to each Chess piece given the current board state.
class MoveGenerator
  def initialize(board)
    @board = board
  end

  def pseudo_legal_moves
    moves = {}

    @board.squares.each_with_index do |piece, position|
      next if piece.nil?

      moves[position] = piece_moves(piece, position)
    end

    moves
  end

  def piece_moves(piece, position)
    case piece
    when Queen, Rook, Bishop
      sliding_moves(piece, position)
    when King, Knight
      non_sliding_moves(piece, position)
    when Pawn
      pawn_moves(piece, position)
    end
  end

  def sliding_moves(piece, position)
    piece.moveset.each_with_object([]) do |delta, next_positions|
      next_position = position + delta
      while targetable_square?(piece, next_position)
        next_positions << next_position
        break unless empty_square?(next_position)

        next_position += delta
      end
    end
  end

  def non_sliding_moves(piece, position)
    piece.moveset.each_with_object([]) do |delta, next_positions|
      next_position = position + delta
      if targetable_square?(piece, next_position)
        next_positions << next_position
      end
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

  def targetable_square?(piece, position)
    on_the_board?(position) &&
      (empty_square?(position) || enemy_square?(piece, position))
  end

  def empty_square?(position)
    @board.squares[position].nil?
  end

  def ally_square?(piece, position)
    target = @board.squares[position]
    target.color != piece.color
  end

  def enemy_square?(piece, position)
    target = @board.squares[position]
    target.color != piece.color
  end
end
