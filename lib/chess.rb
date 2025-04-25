# frozen_string_literal: true

require_relative "board"

# rubocop: disable Metrics/ClassLength

# This class is responsible for managing the main gameplay loop and
# checking for game over conditions.
class Chess
  def initialize
    @board = Board.new
    @color = :white
    @turn = 0
    @history = []
    @move_turn = 0
    @capture_turn = 0
  end

  def play
    until game_over?
      # TODO: main gameplay loop
    end

    game_over_message
  end

  def move_piece(from, to)
    @history << @board.position

    piece = @board.squares[from]
    target = @board.squares[to]

    @move_turn = @turn if piece.is_a?(Pawn)
    @capture_turn = @turn if target

    @board.move_piece(from, to)
  end

  def legal_move?(from, to)
    piece = @board.squares[from]
    return false unless piece
    return false unless piece.moves(@board).include?(to)

    if piece.is_a?(King) && (from - to).abs == 2
      legal_castle?(from, to)
    else
      king_is_safe?(from, to)
    end
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

    king.in_check?(@board) && no_legal_moves?
  end

  def stalemate?
    no_legal_moves? ||
      insufficient_material? ||
      threefold_repetition? ||
      fifty_move_rule?
  end

  def no_legal_moves?
    pieces = @board.get_pieces(@color)

    moves = pieces.each_with_object({}) do |piece, acc|
      acc[piece.square] = piece.moves(@board)
    end

    moves.all? do |from, values|
      values.none? { |to| legal_move?(from, to) }
    end
  end

  # rubocop: disable Metrics/MethodLength
  def insufficient_material?
    case piece_counts
    in { king: 2, **nil } |
       { king: 2, bishop: 1, **nil } |
       { king: 2, knight: 1, **nil } |
       { king: 2, knight: 2, **nil } |
       { king: 2, knight: 1, bishop: 1, **nil }
      true
    in { king: 2, bishop: 2, **nil }
      insufficient_bishops?
    else false
    end
  end
  # rubocop: enable Metrics/MethodLength

  def threefold_repetition?
    current_position = @board.position
    position_count = @history.count do |position|
      position == current_position
    end

    # if current position has already occurred twice
    position_count >= 2
  end

  def fifty_move_rule?
    [@move_turn, @capture_turn].min - @turn >= 50
  end

  def display
    @board.display
  end

  private

  def king_is_safe?(from, to)
    test_board = @board.clone
    test_piece = test_board.squares[from]
    test_board.move_piece(from, to)
    test_king = test_board.get_pieces(test_piece.color).find do |piece|
      piece.is_a?(King)
    end

    !test_king.in_check?(test_board)
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

  def next_turn
    @color = @color == :white ? :black : :white
    @turn += 1 if @color == :white
  end

  def game_over_message
    # TODO: display game over message (winner, stalemate, etc.)
  end
end
# rubocop: enable Metrics/ClassLength
