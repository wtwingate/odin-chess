# frozen_string_literal: true

# This class implements algorithms for calculating all the pseudo-legal
# moves available to each Chess piece given the current board state.
class MoveGenerator
  def initialize(board)
    @board = board
  end

  def pseudo_legal_moves(color)
    moves = {}

    @board.squares.each_with_index do |piece, index|
      next unless piece && piece.color == color

      moves[index] = piece_moves(piece, index)
    end

    moves
  end

  def piece_moves(piece, index)
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
    piece.moveset.each_with_object([]) do |delta, moves|
      next_index = index + delta
      while targetable_square?(piece, next_index)
        moves << next_index
        break unless empty_square?(next_index)

        next_index += delta
      end
    end
  end

  def non_sliding_moves(piece, index)
    piece.moveset.each_with_object([]) do |delta, moves|
      next_index = index + delta
      moves << next_index if targetable_square?(piece, next_index)
    end
  end

  def pawn_moves(pawn, index)
    pawn_pushes(pawn, index) + pawn_attacks(pawn, index)
  end

  private

  # Using an array with 128 indexes enables this clever little method
  # to check for out-of-bounds indexes. For more information, check out
  # https://www.chessprogramming.org/0x88
  def on_the_board?(index)
    index.nobits?(0x88)
  end

  def targetable_square?(piece, index)
    on_the_board?(index) &&
      (empty_square?(index) || enemy_square?(piece, index))
  end

  def empty_square?(index)
    @board.squares[index].nil?
  end

  def ally_square?(piece, index)
    target = @board.squares[index]
    return false unless target

    target.color != piece.color
  end

  def enemy_square?(piece, index)
    target = @board.squares[index]
    return false unless target

    target.color != piece.color
  end

  def en_passant_square?(index)
    index == @board.en_passant
  end

  def pawn_pushes(piece, index)
    steps = []

    next_index = index + piece.moveset.first
    steps << next_index if empty_square?(next_index)

    # steps.empty? means the pawn is blocked
    return steps if piece.moved || steps.empty?

    next_index += piece.moveset.first
    steps << next_index if empty_square?(next_index)

    steps
  end

  def pawn_attacks(piece, index)
    attacks = []

    left_target = index + piece.moveset.first - 1
    right_target = index + piece.moveset.first + 1

    if enemy_square?(piece, left_target) || en_passant_square?(left_target)
      attacks << left_target
    end

    if enemy_square?(piece, right_target) || en_passant_square?(right_target)
      attacks << right_target
    end

    attacks
  end
end
