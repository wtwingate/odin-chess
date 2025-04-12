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
    piece.moveset.each_with_object([]) do |delta, moves|
      next_position = position + delta
      while targetable_square?(piece, next_position)
        moves << next_position
        break unless empty_square?(next_position)

        next_position += delta
      end
    end
  end

  def non_sliding_moves(piece, position)
    piece.moveset.each_with_object([]) do |delta, moves|
      next_position = position + delta
      moves << next_position if targetable_square?(piece, next_position)
    end
  end

  def pawn_moves(piece, position)
    moves = []
    moves += pawn_steps(piece, position)
    moves += pawn_attacks(piece, position)

    moves
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
    return false unless target

    target.color != piece.color
  end

  def enemy_square?(piece, position)
    target = @board.squares[position]
    return false unless target

    target.color != piece.color
  end

  def en_passant_square?(position)
    position == @board.en_passant
  end

  def pawn_steps(piece, position)
    steps = []

    next_position = position + piece.moveset.first
    steps << next_position if empty_square?(next_position)

    # steps.empty? means the pawn is blocked
    return steps if piece.moved || steps.empty?

    next_position += piece.moveset.first
    steps << next_position if empty_square?(next_position)

    steps
  end

  def pawn_attacks(piece, position)
    attacks = []

    left_target = position + piece.moveset.first - 1
    right_target = position + piece.moveset.first + 1

    if enemy_square?(piece, left_target) || en_passant_square?(left_target)
      attacks << left_target
    end

    if enemy_square?(piece, right_target) || en_passant_square?(right_target)
      attacks << right_target
    end

    attacks
  end
end
