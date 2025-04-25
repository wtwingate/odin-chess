# frozen_string_literal: true

require_relative "board"
require_relative "coordinates"

# rubocop: disable Metrics/ClassLength

# This class is responsible for managing the main gameplay loop and
# checking for game over conditions.
class Chess
  include Coordinates

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
      display
      from, to = player_input
      move_piece(from, to)
      next_turn
    end

    game_over_message
  end

  # rubocop: disable Metrics/MethodLength
  def player_input
    loop do
      print prompt
      input = gets.chomp.downcase

      case input
      when "help"
        help_message
      when "quit"
        exit
      else
        begin
          from, to = validate_input(input)
        rescue StandardError
          puts "Invalid input"
          next
        end
      end

      return from, to if legal_move?(from, to)

      puts "Illegal move"
    end
  end
  # rubocop: enable Metrics/MethodLength

  def validate_input(input)
    # expects algebraic notation in the form of "<from>-<to>"
    # e.g. e2-e4, e2e4
    regex = /([a-h][1-8])-?([a-h][1-8])/
    match = regex.match(input)

    raise StandardError unless match

    match.captures.map do |capture|
      coordinate = capture.upcase.to_sym
      Coordinates.const_get(coordinate)
    end
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
    king = @board.get_pieces(@color).find do |piece|
      piece.is_a?(King)
    end

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

  def prompt
    player = @color == :white ? "White" : "Black"
    "#{@turn + 1}) #{player}: "
  end

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
    "Game over!"
  end
end
# rubocop: enable Metrics/ClassLength
