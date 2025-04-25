# frozen_string_literal: true

require "colorize"

require_relative "bishop"
require_relative "coordinates"
require_relative "king"
require_relative "knight"
require_relative "pawn"
require_relative "queen"
require_relative "rook"

# rubocop: disable Metrics/ClassLength

# This class represents a chessboard as a one-dimenstional array of
# squares and provides methods for querying the board state and
# printing the board in ASCII and Unicode formats.
#
# A physical chessboard is composed of 64 squares in an 8x8 grid of
# ranks (rows) and files (columns). In algebraic chess notation, the
# ranks are numbered 1-8, and the files are lettered a-h, like so:
#
#    +----+----+----+----+----+----+----+----+
#    | a8 | b8 | c8 | d8 | e8 | f8 | g8 | h8 |
#    +----+----+----+----+----+----+----+----+
#    | a7 | b7 | c7 | d7 | e7 | f7 | g7 | h7 |
#    +----+----+----+----+----+----+----+----+
#    | a6 | b6 | c6 | d6 | e6 | f6 | g6 | h6 |
#    +----+----+----+----+----+----+----+----+
#    | a5 | b5 | c5 | d5 | e5 | f5 | g5 | h5 |
#    +----+----+----+----+----+----+----+----+
#    | a4 | b4 | c4 | d4 | e4 | f4 | g4 | h4 |
#    +----+----+----+----+----+----+----+----+
#    | a3 | b3 | c3 | d3 | e3 | f3 | g3 | h3 |
#    +----+----+----+----+----+----+----+----+
#    | a2 | b2 | c2 | d2 | e2 | f2 | g2 | h2 |
#    +----+----+----+----+----+----+----+----+
#    | a1 | b1 | c1 | d1 | e1 | f1 | g1 | h1 |
#    +----+----+----+----+----+----+----+----+
#
#
# This uses an array with 128 elements to represent the board. Only
# half of the indexes represent valid board positions; the other half
# are used for out-of-bounds checks.
#
#    +----+----+----+----+----+----+----+----+
#    | 70 | 71 | 72 | 73 | 74 | 75 | 76 | 77 | 78 79 7A 7B 7C 7D 7E 7F
#    +----+----+----+----+----+----+----+----+
#    | 60 | 61 | 62 | 63 | 64 | 65 | 66 | 67 | 68 69 6A 6B 6C 6D 6E 6F
#    +----+----+----+----+----+----+----+----+
#    | 50 | 51 | 52 | 53 | 54 | 55 | 56 | 57 | 58 59 5A 5B 5C 5D 5E 5F
#    +----+----+----+----+----+----+----+----+
#    | 40 | 41 | 42 | 43 | 44 | 45 | 46 | 47 | 48 49 4A 4B 4C 4D 4E 4F
#    +----+----+----+----+----+----+----+----+
#    | 30 | 31 | 32 | 33 | 34 | 35 | 36 | 37 | 38 39 3A 3B 3C 3D 3E 3F
#    +----+----+----+----+----+----+----+----+
#    | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 29 2A 2B 2C 2D 2E 2F
#    +----+----+----+----+----+----+----+----+
#    | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 19 1A 1B 1C 1D 1E 1F
#    +----+----+----+----+----+----+----+----+
#    | 00 | 01 | 02 | 03 | 04 | 05 | 06 | 07 | 08 09 0A 0B 0C 0D 0E 0F
#    +----+----+----+----+----+----+----+----+
#
# Using a one-dimenstional array like this for our squares allows us to
# iterate through all the squares and calculate moves a bit more
# efficiently, at the cost of a little mental overhead.
class Board
  include Coordinates

  attr_reader :squares, :en_passant

  def initialize
    @squares = starting_position
    @en_passant = nil # [passed_square, pawn_square]
  end

  def initialize_copy(original)
    @squares = original.squares.map(&:clone)
    @en_passant = original.en_passant
  end

  def move_piece(from, to, promotion = nil)
    piece = @squares[from]

    # Update the piece state
    piece.square = to

    # Update the board state
    @squares[to] = piece
    @squares[from] = nil
    update_en_passant(from, to)

    promote_pawn(piece, promotion) if promotion
  end

  def get_pieces(color = nil)
    @squares.select do |piece|
      piece && (color.nil? || piece.color == color)
    end
  end

  def in_bounds?(index)
    index.nobits?(0x88)
  end

  def empty_square?(index)
    @squares[index].nil?
  end

  def ally_square?(index, color)
    piece = @squares[index]
    piece && piece.color == color
  end

  def enemy_square?(index, color)
    piece = @squares[index]
    piece && piece.color != color
  end

  def targetable_square?(index, color)
    in_bounds?(index) && (empty_square?(index) || enemy_square?(index, color))
  end

  def targeted_square?(index, color)
    enemy_color = color == :white ? :black : :white
    enemy_pieces = get_pieces(enemy_color)
    enemy_pieces.any? { |piece| piece.moves(self).include?(index) }
  end

  def en_passant_square?(index)
    passed_square, = @en_passant
    index == passed_square
  end

  # rubocop: disable Metrics
  def display
    puts
    7.downto(0).each do |rank|
      print "#{rank + 1} "
      0.upto(7).each do |file|
        piece = @squares[(rank * 16) + file]
        print "#{piece ? piece.unicode : ' '} "
          .colorize(color: :black, background: square_color(rank, file))
      end
      print "\n"
    end
    puts "  a b c d e f g h"
    puts
  end
  # rubocop: enable Metrics

  def position
    export_position
  end

  private

  # rubocop: disable Metrics/MethodLength
  def update_en_passant(from, to)
    # pawn double push
    piece = @squares[to]
    diff = (from - to).abs
    if piece.is_a?(Pawn) && diff == 0x20
      passed_square = (from + to) / 2
      @en_passant = [passed_square, to]
      return
    end

    # en passant capture
    passed_square, pawn_square = @en_passant
    if passed_square == to
      @squares[pawn_square] = nil
      @en_passant = nil
      return
    end

    # regular move/capture
    @en_passant = nil
  end
  # rubocop: enable Metrics/MethodLength

  # rubocop: disable Metrics
  def promote_pawn(pawn, promotion)
    case promotion
    when :queen
      promoted_pawn = Queen.new(pawn.color, pawn.starting_square)
    when :rook
      promoted_pawn = Rook.new(pawn.color, pawn.starting_square)
    when :bishop
      promoted_pawn = Bishop.new(pawn.color, pawn.starting_square)
    when :knight
      promoted_pawn = Knight.new(pawn.color, pawn.starting_square)
    end

    promoted_pawn.square = pawn.square
    @squares[pawn.square] = promoted_pawn
  end
  # rubocop: enable Metrics

  def starting_position
    position = "RNBQKBNR........" \
               "PPPPPPPP........" \
               "................" \
               "................" \
               "................" \
               "................" \
               "pppppppp........" \
               "rnbqkbnr........"

    import_position(position)
  end

  # rubocop: disable Metrics
  def import_position(position)
    tokens = position.chars

    tokens.each_with_index.map do |piece, index|
      case piece
      when "K" then King.new(:white, index)
      when "Q" then Queen.new(:white, index)
      when "R" then Rook.new(:white, index)
      when "B" then Bishop.new(:white, index)
      when "N" then Knight.new(:white, index)
      when "P" then Pawn.new(:white, index)
      when "k" then King.new(:black, index)
      when "q" then Queen.new(:black, index)
      when "r" then Rook.new(:black, index)
      when "b" then Bishop.new(:black, index)
      when "n" then Knight.new(:black, index)
      when "p" then Pawn.new(:black, index)
      end
    end
  end
  # rubocop: enable Metrics

  def export_position
    @squares.map { |piece| piece ? piece.ascii : "." }.join
  end

  def square_color(rank, file)
    (rank + file).even? ? :magenta : :white
  end
end
# rubocop: enable Metrics/ClassLength
