# frozen_string_literal: true

require_relative "board"

# This class is responsible for managing the main gameplay loop and
# checking for game over conditions.
class Chess
  def initialize
    @board = Board.new
    @color = :white
    @turn = 0
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
    # https://www.chess.com/article/view/how-chess-games-can-end-8-ways-explained
    checkmate? || stalemate?
  end

  def checkmate?
    king = @board.get_king(@color)

    king.in_check?(@board) && no_legal_moves?(@color)
  end

  def stalemate?
    # TODO: check for stalemate conditions
    # - No legal moves
    # - Insufficient material
    # - Threefold repetition
    # - Fifty-move rule
  end

  def no_legal_moves?(color)
    pieces = @board.get_pieces(color)

    moves = pieces.each_with_object({}) do |piece, acc|
      acc[piece.square] = piece.moves(@board)
    end

    moves.none? do |from, values|
      values.none? { |to| legal_move?(from, to) }
    end
  end

  def insufficient_material?
    # king vs king
    # king + minor vs king
    # king + minor vs king + minor
    # king + two knights vs king
  end

  private

  def next_turn
    @color = @color == :white ? :black : :white
    @turn += 1 if @color == :white
  end

  def game_over_message
    # TODO: display game over message (winner, stalemate, etc.)
  end
end
