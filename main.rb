# frozen_string_literal: true

require_relative "lib/board"
require_relative "lib/coordinates"
require_relative "lib/deltas"
require_relative "lib/piece"
require_relative "lib/king"
require_relative "lib/queen"
require_relative "lib/rook"
require_relative "lib/bishop"
require_relative "lib/knight"
require_relative "lib/pawn"

board = Board.new

board.ascii_print
board.unicode_print
