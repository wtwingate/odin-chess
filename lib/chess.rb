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
    checkmate? || stalemate?
  end

  def checkmate?
    king = @board.get_king(@color)

    king.in_check?(@board) && no_legal_moves?(@color)
  end

  def stalemate?
    no_legal_moves?(@color) || insufficient_material? ||
      threefold_repition? || fifty_move_rule?
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

  # rubocop: disable Metrics/MethodLength
  def insufficient_material?
    case piece_counts
    in { king: 2, **nil },
       { king: 2, bishop: 1, **nil },
       { king: 2, knight: 1, **nil },
       { king: 2, knight: 2, **nil },
       { king: 2, knight: 1, bishop: 1, **nil }
      true
    in { king: 2, bishop: 2, **nil }
      insufficient_bishops?
    else false
    end
  end
  # rubocop: enable Metrics/MethodLength

  def threefold_repition?
    # TODO
  end

  def fifty_move_rule?
    # TODO
  end

  private

  def next_turn
    @color = @color == :white ? :black : :white
    @turn += 1 if @color == :white
  end

  def piece_counts
    pieces = @board.get_pieces
    pieces.each_with_object(Hash.new(0)) do |piece, counts|
      counts[piece.class.name.downcase.to_sym] += 1
    end
  end

  def insufficient_bishops?
    bishops = @board.get_pieces.select do |piece|
      piece.is_a?(Bishop)
    end

    bishops[0].color != bishops[1].color
  end

  def game_over_message
    # TODO: display game over message (winner, stalemate, etc.)
  end
end
