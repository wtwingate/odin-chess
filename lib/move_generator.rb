require_relative 'coordinates'

class MoveGenerator
  def initialize(board)
    @board = board
  end

  def pseudo_legal_moves
    moves = {}

    Coordinates::ALL.each do |coords|
      piece = @board.squares[coords]
      next unless piece

      moves[coords] = calculate_moves(coords, piece)
    end

    moves
  end

  def calculate_moves(coords, piece)
    case piece
    when Queen, Rook, Bishop
      sliding_moves(coords, piece)
    when King, Knight
      non_sliding_moves(coords, piece)
    when Pawn
      pawn_moves(coords, piece)
    end
  end

  def sliding_moves(coords, piece)
    # TODO
  end

  def non_sliding_moves(coords, piece)
    moves = piece.moveset.map { |delta| coords + delta }
    moves.select do |move|
      on_the_board(move) && no_wrap(coords, move) && no_friendly_fire(piece, move)
    end
  end

  def pawn_moves(coords, piece)
    # TODO
  end

  private

  def on_the_board(coords)
    coords >= 0 && coords <= 63
  end

  def no_wrap(coords, move)
    ((coords % 8) - (move % 8)).abs < 2
  end

  def no_friendly_fire(piece, move)
    target = @board.squares[move]
    return true unless target

    piece.color != target.color
  end
end
