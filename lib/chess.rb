# frozen_string_literal: true

require_relative "board"

# This class is responsible for managing the main gameplay loop and
# checking for game over conditions.
class Chess
  def initialize
    @board = Board.new
  end

  def play
    until game_over?
      # TODO: main gameplay loop
    end

    game_over_message
  end

  def legal_move?(from, to)
    # Check if the move is a pseudo-legal move
    piece = @board.squares[from]
    return false unless piece.moves(@board).include?(to)

    return legal_castle?(from, to) if piece.is_a?(King) && (from - to).abs == 2

    # Check if the move puts the ally king in check
    test_board = @board.clone
    test_board.move_piece(from, to)
    test_king = test_board.get_king(piece.color)

    !test_king.in_check?(test_board)
  end

  def legal_castle?(from, to)
    king = @board.squares[from]

    start, finish = [from, to].sort
    (start..finish).none? do |square|
      @board.targeted_square?(square, king.color)
    end
  end

  def game_over?
    checkmate? || stalemate?
  end

  def checkmate?
    # TODO: check for checkmate condition
  end

  def stalemate?
    # TODO: check for stalemate conditions
    # - No legal moves
    # - Insufficient material
    # - Threefold repetition
    # - Fifty-move rule
  end

  private

  def game_over_message
    # TODO: display game over message (winner, stalemate, etc.)
  end
end
