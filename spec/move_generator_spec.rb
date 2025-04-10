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

  describe "#non-sliding-moves" do
    context "when moving a King" do
      let(:king) { King.new(:white) }
      let(:squares) { Array.new(64) }

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
      let(:squares) { Array.new(64) }

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

      it "returns all enemy-occupied squares" do
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
end
