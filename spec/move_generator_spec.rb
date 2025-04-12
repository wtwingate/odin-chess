# frozen_string_literal: true

require_relative "../lib/bishop"
require_relative "../lib/board"
require_relative "../lib/king"
require_relative "../lib/knight"
require_relative "../lib/move_generator"
require_relative "../lib/pawn"
require_relative "../lib/piece"
require_relative "../lib/queen"
require_relative "../lib/rook"

describe MoveGenerator do
  subject(:move_generator) { described_class.new(board) }

  let(:board) { instance_double(Board) }

  describe "#sliding_moves" do
    context "when moving a Queen" do
      let(:queen) { Queen.new(:white) }
      let(:squares) { Array.new(128) }

      before do
        allow(board).to receive(:squares).and_return(squares)
      end

      it "returns all moves from the middle of the board" do
        queen_moves = [E5, E6, E7, E8, F5, G6, H7, F4, G4, H4, F3, G2, H1, E3,
                       E2, E1, D3, C2, B1, D4, C4, B4, A4, D5, C6, B7, A8]
        result = move_generator.sliding_moves(queen, E4)
        expect(result).to eq(queen_moves)
      end

      it "returns all moves from the bottom-left-corner of the board" do
        queen_moves = [A2, A3, A4, A5, A6, A7, A8, B2, C3, D4, E5, F6, G7, H8,
                       B1, C1, D1, E1, F1, G1, H1]
        result = move_generator.sliding_moves(queen, A1)
        expect(result).to eq(queen_moves)
      end

      it "returns all moves from the bottom-right corner of the board" do
        queen_moves = [H2, H3, H4, H5, H6, H7, H8, G1, F1, E1, D1, C1, B1, A1,
                       G2, F3, E4, D5, C6, B7, A8]
        result = move_generator.sliding_moves(queen, H1)
        expect(result).to eq(queen_moves)
      end

      it "returns all moves from the top-left corner of the board" do
        queen_moves = [B8, C8, D8, E8, F8, G8, H8, B7, C6, D5, E4, F3, G2, H1,
                       A7, A6, A5, A4, A3, A2, A1]
        result = move_generator.sliding_moves(queen, A8)
        expect(result).to eq(queen_moves)
      end

      it "returns all moves from the top-right corner of the board" do
        queen_moves = [H7, H6, H5, H4, H3, H2, H1, G7, F6, E5, D4, C3, B2, A1,
                       G8, F8, E8, D8, C8, B8, A8]
        result = move_generator.sliding_moves(queen, H8)
        expect(result).to eq(queen_moves)
      end

      it "returns all moves from the left edge of the board" do
        queen_moves = [A5, A6, A7, A8, B5, C6, D7, E8, B4, C4, D4, E4, F4, G4,
                       H4, B3, C2, D1, A3, A2, A1]
        result = move_generator.sliding_moves(queen, A4)
        expect(result).to eq(queen_moves)
      end

      it "returns all moves from the right edge of the board" do
        queen_moves = [H5, H6, H7, H8, H3, H2, H1, G3, F2, E1, G4, F4, E4, D4,
                       C4, B4, A4, G5, F6, E7, D8]
        result = move_generator.sliding_moves(queen, H4)
        expect(result).to eq(queen_moves)
      end

      it "returns all moves from the top edge of the board" do
        queen_moves = [F8, G8, H8, F7, G6, H5, E7, E6, E5, E4, E3, E2, E1, D7,
                       C6, B5, A4, D8, C8, B8, A8]
        result = move_generator.sliding_moves(queen, E8)
        expect(result).to eq(queen_moves)
      end

      it "returns all moves from the bottom edge of the board" do
        queen_moves = [E2, E3, E4, E5, E6, E7, E8, F2, G3, H4, F1, G1, H1, D1,
                       C1, B1, A1, D2, C3, B4, A5]
        result = move_generator.sliding_moves(queen, E1)
        expect(result).to eq(queen_moves)
      end
    end

    context "when moving a Rook" do
      let(:rook) { Rook.new(:white) }
      let(:squares) { Array.new(128) }

      before do
        allow(board).to receive(:squares).and_return(squares)
      end

      it "returns all moves from the middle of the board" do
        rook_moves = [E5, E6, E7, E8, F4, G4, H4, E3, E2, E1, D4, C4, B4, A4]
        result = move_generator.sliding_moves(rook, E4)
        expect(result).to eq(rook_moves)
      end

      it "returns all moves from the bottom-left-corner of the board" do
        rook_moves = [A2, A3, A4, A5, A6, A7, A8, B1, C1, D1, E1, F1, G1, H1]
        result = move_generator.sliding_moves(rook, A1)
        expect(result).to eq(rook_moves)
      end

      it "returns all moves from the bottom-right corner of the board" do
        rook_moves = [H2, H3, H4, H5, H6, H7, H8, G1, F1, E1, D1, C1, B1, A1]
        result = move_generator.sliding_moves(rook, H1)
        expect(result).to eq(rook_moves)
      end

      it "returns all moves from the top-left corner of the board" do
        rook_moves = [B8, C8, D8, E8, F8, G8, H8, A7, A6, A5, A4, A3, A2, A1]
        result = move_generator.sliding_moves(rook, A8)
        expect(result).to eq(rook_moves)
      end

      it "returns all moves from the top-right corner of the board" do
        rook_moves = [H7, H6, H5, H4, H3, H2, H1, G8, F8, E8, D8, C8, B8, A8]
        result = move_generator.sliding_moves(rook, H8)
        expect(result).to eq(rook_moves)
      end

      it "returns all moves from the left edge of the board" do
        rook_moves = [A5, A6, A7, A8, B4, C4, D4, E4, F4, G4, H4, A3, A2, A1]
        result = move_generator.sliding_moves(rook, A4)
        expect(result).to eq(rook_moves)
      end

      it "returns all moves from the right edge of the board" do
        rook_moves = [H5, H6, H7, H8, H3, H2, H1, G4, F4, E4, D4, C4, B4, A4]
        result = move_generator.sliding_moves(rook, H4)
        expect(result).to eq(rook_moves)
      end

      it "returns all moves from the top edge of the board" do
        rook_moves = [F8, G8, H8, E7, E6, E5, E4, E3, E2, E1, D8, C8, B8, A8]
        result = move_generator.sliding_moves(rook, E8)
        expect(result).to eq(rook_moves)
      end

      it "returns all moves from the bottom edge of the board" do
        rook_moves = [E2, E3, E4, E5, E6, E7, E8, F1, G1, H1, D1, C1, B1, A1]
        result = move_generator.sliding_moves(rook, E1)
        expect(result).to eq(rook_moves)
      end
    end

    context "when moving a Bishop" do
      let(:bishop) { Bishop.new(:white) }
      let(:squares) { Array.new(128) }

      before do
        allow(board).to receive(:squares).and_return(squares)
      end

      it "returns all moves from the middle of the board" do
        bishop_moves = [F5, G6, H7, F3, G2, H1, D3, C2, B1, D5, C6, B7, A8]
        result = move_generator.sliding_moves(bishop, E4)
        expect(result).to eq(bishop_moves)
      end

      it "returns all moves from the bottom-left-corner of the board" do
        bishop_moves = [B2, C3, D4, E5, F6, G7, H8]
        result = move_generator.sliding_moves(bishop, A1)
        expect(result).to eq(bishop_moves)
      end

      it "returns all moves from the bottom-right corner of the board" do
        bishop_moves = [G2, F3, E4, D5, C6, B7, A8]
        result = move_generator.sliding_moves(bishop, H1)
        expect(result).to eq(bishop_moves)
      end

      it "returns all moves from the top-left corner of the board" do
        bishop_moves = [B7, C6, D5, E4, F3, G2, H1]
        result = move_generator.sliding_moves(bishop, A8)
        expect(result).to eq(bishop_moves)
      end

      it "returns all moves from the top-right corner of the board" do
        bishop_moves = [G7, F6, E5, D4, C3, B2, A1]
        result = move_generator.sliding_moves(bishop, H8)
        expect(result).to eq(bishop_moves)
      end

      it "returns all moves from the left edge of the board" do
        bishop_moves = [B5, C6, D7, E8, B3, C2, D1]
        result = move_generator.sliding_moves(bishop, A4)
        expect(result).to eq(bishop_moves)
      end

      it "returns all moves from the right edge of the board" do
        bishop_moves = [G3, F2, E1, G5, F6, E7, D8]
        result = move_generator.sliding_moves(bishop, H4)
        expect(result).to eq(bishop_moves)
      end

      it "returns all moves from the top edge of the board" do
        bishop_moves = [F7, G6, H5, D7, C6, B5, A4]
        result = move_generator.sliding_moves(bishop, E8)
        expect(result).to eq(bishop_moves)
      end

      it "returns all moves from the bottom edge of the board" do
        bishop_moves = [F2, G3, H4, D2, C3, B4, A5]
        result = move_generator.sliding_moves(bishop, E1)
        expect(result).to eq(bishop_moves)
      end
    end

    context "when a piece is surrounded by enemy pieces" do
      let(:queen) { Queen.new(:white) }
      let(:squares) { Array.new(128) { Pawn.new(:black) } }

      before do
        allow(board).to receive(:squares).and_return(squares)
        squares[E4] = queen
      end

      it "returns all attackable enemy-occupied squares" do
        queen_moves = [E5, F5, F4, F3, E3, D3, D4, D5]
        result = move_generator.sliding_moves(queen, E4)
        expect(result).to eq(queen_moves)
      end
    end

    context "when a piece is surrounded by ally pieces" do
      let(:queen) { Queen.new(:white) }
      let(:squares) { Array.new(128) { Pawn.new(:white) } }

      before do
        allow(board).to receive(:squares).and_return(squares)
        squares[E4] = queen
      end

      it "does not return any ally-occupied squares" do
        queen_moves = []
        result = move_generator.sliding_moves(queen, E4)
        expect(result).to eq(queen_moves)
      end
    end
  end

  describe "#non_sliding_moves" do
    context "when moving a King" do
      let(:king) { King.new(:white) }
      let(:squares) { Array.new(128) }

      before do
        allow(board).to receive(:squares).and_return(squares)
      end

      it "returns all moves from the middle of the board" do
        king_moves = [E5, F5, F4, F3, E3, D3, D4, D5]
        result = move_generator.non_sliding_moves(king, E4)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the bottom-left corner of the board" do
        king_moves = [A2, B2, B1]
        result = move_generator.non_sliding_moves(king, A1)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the bottom-right corner of the board" do
        king_moves = [H2, G1, G2]
        result = move_generator.non_sliding_moves(king, H1)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the top-left corner of the board" do
        king_moves = [B8, B7, A7]
        result = move_generator.non_sliding_moves(king, A8)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the top-right corner of the board" do
        king_moves = [H7, G7, G8]
        result = move_generator.non_sliding_moves(king, H8)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the left edge of the board" do
        king_moves = [A5, B5, B4, B3, A3]
        result = move_generator.non_sliding_moves(king, A4)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the right edge of the board" do
        king_moves = [H5, H3, G3, G4, G5]
        result = move_generator.non_sliding_moves(king, H4)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the top edge of the board" do
        king_moves = [F8, F7, E7, D7, D8]
        result = move_generator.non_sliding_moves(king, E8)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the bottom edge of the board" do
        king_moves = [E2, F2, F1, D1, D2]
        result = move_generator.non_sliding_moves(king, E1)
        expect(result).to eq(king_moves)
      end
    end

    context "when moving a Knight" do
      let(:knight) { Knight.new(:white) }
      let(:squares) { Array.new(128) }

      before do
        allow(board).to receive(:squares).and_return(squares)
      end

      it "returns all moves from the middle of the board" do
        knight_moves = [F6, G5, G3, F2, D2, C3, C5, D6]
        result = move_generator.non_sliding_moves(knight, E4)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the bottom-left corner of the board" do
        knight_moves = [B3, C2]
        result = move_generator.non_sliding_moves(knight, A1)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the bottom-right corner of the board" do
        knight_moves = [F2, G3]
        result = move_generator.non_sliding_moves(knight, H1)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the top-left corner of the board" do
        knight_moves = [C7, B6]
        result = move_generator.non_sliding_moves(knight, A8)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the top-right corner of the board" do
        knight_moves = [G6, F7]
        result = move_generator.non_sliding_moves(knight, H8)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the left edge of the board" do
        knight_moves = [B6, C5, C3, B2]
        result = move_generator.non_sliding_moves(knight, A4)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the right edge of the board" do
        knight_moves = [G2, F3, F5, G6]
        result = move_generator.non_sliding_moves(knight, H4)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the top edge of the board" do
        knight_moves = [G7, F6, D6, C7]
        result = move_generator.non_sliding_moves(knight, E8)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the bottom edge of the board" do
        knight_moves = [F3, G2, C2, D3]
        result = move_generator.non_sliding_moves(knight, E1)
        expect(result).to eq(knight_moves)
      end
    end

    context "when a piece is surrounded by enemy pieces" do
      let(:king) { King.new(:white) }
      let(:squares) { Array.new(128) { Pawn.new(:black) } }

      before do
        allow(board).to receive(:squares).and_return(squares)
        squares[E4] = king
      end

      it "returns all attackable enemy-occupied squares" do
        king_moves = [E5, F5, F4, F3, E3, D3, D4, D5]
        result = move_generator.non_sliding_moves(king, E4)
        expect(result).to eq(king_moves)
      end
    end

    context "when a piece is surrounded by ally pieces" do
      let(:king) { King.new(:white) }
      let(:squares) { Array.new(128) { Pawn.new(:white) } }

      before do
        allow(board).to receive(:squares).and_return(squares)
        squares[E4] = king
      end

      it "does not return any ally-occupied squares" do
        king_moves = []
        result = move_generator.non_sliding_moves(king, E4)
        expect(result).to eq(king_moves)
      end
    end
  end

  describe "#pawn_moves" do
    let(:white_pawn) { Pawn.new(:white) }
    let(:black_pawn) { Pawn.new(:black) }
    let(:squares) { Array.new(128) }

    before do
      allow(board).to receive_messages(squares: squares, en_passant: nil)
    end

    context "when a white Pawn is in its initial position" do
      it "can move up two squares" do
        white_pawn_moves = [E3, E4]
        result = move_generator.pawn_moves(white_pawn, E2)
        expect(result).to eq(white_pawn_moves)
      end
    end

    context "when a black Pawn is in its initial position" do
      it "can move down two squares" do
        black_pawn_moves = [E6, E5]
        result = move_generator.pawn_moves(black_pawn, E7)
        expect(result).to eq(black_pawn_moves)
      end
    end

    context "when a white Pawn is not in its initial position" do
      before do
        white_pawn.instance_variable_set(:@moved, true)
      end

      it "can move up one square" do
        white_pawn_moves = [E5]
        result = move_generator.pawn_moves(white_pawn, E4)
        expect(result).to eq(white_pawn_moves)
      end
    end

    context "when a black Pawn is not in its initial position" do
      before do
        black_pawn.instance_variable_set(:@moved, true)
      end

      it "can move down one square" do
        black_pawn_moves = [E4]
        result = move_generator.pawn_moves(black_pawn, E5)
        expect(result).to eq(black_pawn_moves)
      end
    end

    context "when an unmoved white Pawn has enemies in its attack range" do
      before do
        squares[D3] = black_pawn
        squares[F3] = black_pawn
      end

      it "can move up two squares or capture its enemies" do
        white_pawn_moves = [E3, E4, D3, F3]
        result = move_generator.pawn_moves(white_pawn, E2)
        expect(result).to eq(white_pawn_moves)
      end
    end

    context "when an unmoved black Pawn has enemies in its attack range" do
      before do
        squares[D6] = white_pawn
        squares[F6] = white_pawn
      end

      it "can move down two squares or capture its enemies" do
        black_pawn_moves = [E6, E5, D6, F6]
        result = move_generator.pawn_moves(black_pawn, E7)
        expect(result).to eq(black_pawn_moves)
      end
    end

    context "when a moved white Pawn has enemies in its attack range" do
      before do
        white_pawn.instance_variable_set(:@moved, true)
        squares[D5] = black_pawn
        squares[F5] = black_pawn
      end

      it "can move up one square or capture its enemies" do
        white_pawn_moves = [E5, D5, F5]
        result = move_generator.pawn_moves(white_pawn, E4)
        expect(result).to eq(white_pawn_moves)
      end
    end

    context "when a moved black Pawn has enemies in its attack range" do
      before do
        black_pawn.instance_variable_set(:@moved, true)
        squares[D4] = white_pawn
        squares[F4] = white_pawn
      end

      it "can move down two squares or capture its enemies" do
        black_pawn_moves = [E4, D4, F4]
        result = move_generator.pawn_moves(black_pawn, E5)
        expect(result).to eq(black_pawn_moves)
      end
    end

    context "when a white Pawn is blocked by an ally" do
      before do
        squares[E3] = white_pawn
      end

      it "cannot move up" do
        white_pawn_moves = []
        result = move_generator.pawn_moves(white_pawn, E2)
        expect(result).to eq(white_pawn_moves)
      end
    end

    context "when a black Pawn is blocked by an ally" do
      before do
        squares[E6] = black_pawn
      end

      it "cannot move down" do
        black_pawn_moves = []
        result = move_generator.pawn_moves(black_pawn, E7)
        expect(result).to eq(black_pawn_moves)
      end
    end

    context "when a white Pawn is blocked by an enemy" do
      before do
        squares[E3] = black_pawn
      end

      it "cannot move up" do
        white_pawn_moves = []
        result = move_generator.pawn_moves(white_pawn, E2)
        expect(result).to eq(white_pawn_moves)
      end
    end

    context "when a black Pawn is blocked by an enemy" do
      before do
        squares[E6] = white_pawn
      end

      it "cannot move down" do
        black_pawn_moves = []
        result = move_generator.pawn_moves(black_pawn, E7)
        expect(result).to eq(black_pawn_moves)
      end
    end

    context "when a white Pawn is blocked but has enemies in attack range" do
      before do
        squares[E3] = white_pawn
        squares[D3] = black_pawn
        squares[F3] = black_pawn
      end

      it "cannot move up but can capture its enemies" do
        white_pawn_moves = [D3, F3]
        result = move_generator.pawn_moves(white_pawn, E2)
        expect(result).to eq(white_pawn_moves)
      end
    end

    context "when a black Pawn is blocked but has enemies in attack range" do
      before do
        squares[E6] = black_pawn
        squares[D6] = white_pawn
        squares[F6] = white_pawn
      end

      it "cannot move down but can capture its enemies" do
        black_pawn_moves = [D6, F6]
        result = move_generator.pawn_moves(black_pawn, E7)
        expect(result).to eq(black_pawn_moves)
      end
    end

    context "when a white Pawn is next to an en passant target" do
      before do
        allow(board).to receive(:en_passant).and_return(D6)
        white_pawn.instance_variable_set(:@moved, true)
        squares[D5] = black_pawn
      end

      it "can capture the en passant target" do
        white_pawn_moves = [E6, D6]
        result = move_generator.pawn_moves(white_pawn, E5)
        expect(result).to eq(white_pawn_moves)
      end
    end

    context "when a black Pawn is next to an en passant target" do
      before do
        allow(board).to receive(:en_passant).and_return(D3)
        black_pawn.instance_variable_set(:@moved, true)
        squares[D4] = white_pawn
      end

      it "can capture the en passant target" do
        black_pawn_moves = [E3, D3]
        result = move_generator.pawn_moves(black_pawn, E4)
        expect(result).to eq(black_pawn_moves)
      end
    end

    context "when a white Pawn is not next to an en passant target" do
      before do
        allow(board).to receive(:en_passant).and_return(C6)
        white_pawn.instance_variable_set(:@moved, true)
        squares[C5] = black_pawn
      end

      it "cannot capture the en passant target" do
        white_pawn_moves = [E6]
        result = move_generator.pawn_moves(white_pawn, E5)
        expect(result).to eq(white_pawn_moves)
      end
    end

    context "when a black Pawn is not next to an en passant target" do
      before do
        allow(board).to receive(:en_passant).and_return(C3)
        black_pawn.instance_variable_set(:@moved, true)
        squares[C4] = white_pawn
      end

      it "cannot capture the en passant target" do
        black_pawn_moves = [E3]
        result = move_generator.pawn_moves(black_pawn, E4)
        expect(result).to eq(black_pawn_moves)
      end
    end
  end
end
