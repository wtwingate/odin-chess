# frozen_string_literal: true

require_relative "deltas"

# This is the base class for the various chess pieces.
class Piece
  attr_accessor :square
  attr_reader :color, :starting_square

  def initialize(color, square)
    @color = color
    @square = square
    @starting_square = square
  end

  def moved?
    @square != @starting_square
  end
end
