# frozen_string_literal: true

require "colorize"
require_relative "coordinates"

# This class represents a chessboard as a one-dimenstional array of
# squares and provides methods for printing it to the console.
#
# A physical chessboard is composed of 64 squares in an 8x8 grid of
# ranks (rows) and files (columns). In algebraic chess notation, the
# ranks are numbered 1-8, and the files are lettered a-h, like so:
#
#    +----+----+----+----+----+----+----+----+
#    | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 |
#    +----+----+----+----+----+----+----+----+
#    | g1 | g2 | g3 | g4 | g5 | g6 | g7 | g8 |
#    +----+----+----+----+----+----+----+----+
#    | f1 | f2 | f3 | f4 | f5 | f6 | f7 | f8 |
#    +----+----+----+----+----+----+----+----+
#    | e1 | e2 | e3 | e4 | e5 | e6 | e7 | e8 |
#    +----+----+----+----+----+----+----+----+
#    | d1 | d2 | d3 | d4 | d5 | d6 | d7 | d8 |
#    +----+----+----+----+----+----+----+----+
#    | c1 | c2 | c3 | c4 | c5 | c6 | c7 | c8 |
#    +----+----+----+----+----+----+----+----+
#    | b1 | b2 | b3 | b4 | b5 | b6 | b7 | b8 |
#    +----+----+----+----+----+----+----+----+
#    | a1 | a2 | a3 | a4 | a5 | a6 | a7 | a8 |
#    +----+----+----+----+----+----+----+----+
#
# In the array, the coordinates a1...h8 corresponds to indexes 0...63,
# as illustrated below:
#
#    +----+----+----+----+----+----+----+----+
#    | 56 | 57 | 58 | 59 | 60 | 61 | 62 | 63 |
#    +----+----+----+----+----+----+----+----+
#    | 48 | 49 | 50 | 51 | 52 | 53 | 54 | 55 |
#    +----+----+----+----+----+----+----+----+
#    | 40 | 41 | 42 | 43 | 44 | 45 | 46 | 47 |
#    +----+----+----+----+----+----+----+----+
#    | 32 | 33 | 34 | 35 | 36 | 37 | 38 | 39 |
#    +----+----+----+----+----+----+----+----+
#    | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 |
#    +----+----+----+----+----+----+----+----+
#    | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 |
#    +----+----+----+----+----+----+----+----+
#    | 08 | 09 | 10 | 11 | 12 | 13 | 14 | 15 |
#    +----+----+----+----+----+----+----+----+
#    | 00 | 01 | 02 | 03 | 04 | 05 | 06 | 07 |
#    +----+----+----+----+----+----+----+----+
#
# Using a one-dimenstional array like this for our squares allows us to
# iterate through all the squares and calculate moves a bit more
# efficiently, at the cost of a little mental overhead.
class Board
  include Coordinates

  def initialize
    @squares = initial_position
  end

  def ascii_print
    7.downto(0).each do |rank|
      0.upto(7).each do |file|
        piece = @squares[(rank * 8) + file]
        print "#{piece ? piece.ascii : '.'} "
      end
      print "\n"
    end
  end

  def unicode_print
    7.downto(0).each do |rank|
      0.upto(7).each do |file|
        piece = @squares[(rank * 8) + file]
        print "#{piece ? piece.unicode : ' '} "
          .colorize(color: :black, background: square_color(rank, file))
      end
      print "\n"
    end
  end

  private

  # rubocop: disable Metrics
  def initial_position
    layout = [
      "R N B Q K B N R",
      "P P P P P P P P",
      ". . . . . . . .",
      ". . . . . . . .",
      ". . . . . . . .",
      ". . . . . . . .",
      "p p p p p p p p",
      "r n b q k b n r"
    ]

    tokens = layout.flat_map(&:split)

    tokens.map do |token|
      case token
      when "K" then King.new(:white)
      when "Q" then Queen.new(:white)
      when "R" then Rook.new(:white)
      when "B" then Bishop.new(:white)
      when "N" then Knight.new(:white)
      when "P" then Pawn.new(:white)
      when "k" then King.new(:black)
      when "q" then Queen.new(:black)
      when "r" then Rook.new(:black)
      when "b" then Bishop.new(:black)
      when "n" then Knight.new(:black)
      when "p" then Pawn.new(:black)
      end
    end
  end
  # rubocop: enable Metrics

  def square_color(rank, file)
    (rank + file).even? ? :magenta : :white
  end
end
