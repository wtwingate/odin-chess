# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/king"
require_relative "../lib/queen"
require_relative "../lib/rook"
require_relative "../lib/bishop"
require_relative "../lib/knight"
require_relative "../lib/pawn"
require_relative "../lib/move_generator"
require_relative "../lib/piece"

describe MoveGenerator do
  subject(:move_generator) { described_class.new(board) }

  let(:board) { instance_double(Board) }

  describe "#pseudo_legal_moves" do
    context "when the Board is empty" do
      before do
        squares = Array.new(64)
        allow(board).to receive(:squares).and_return(squares)
      end

      it "returns an empty Hash" do
        result = move_generator.pseudo_legal_moves
        expect(result).to eq({})
      end
    end
  end

  describe "#non-sliding-moves" do
    context "when moving a King" do
      let(:king) { King.new(:white) }
      let(:squares) { Array.new(64) }

      before do
        allow(board).to receive(:squares).and_return(squares)
      end

      it "returns all moves from the middle of the board" do
        king_moves = [35, 36, 28, 20, 19, 18, 26, 34]
        result = move_generator.non_sliding_moves(27, king)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the bottom-left corner of the board" do
        king_moves = [8, 9, 1]
        result = move_generator.non_sliding_moves(0, king)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the bottom-right corner of the board" do
        king_moves = [15, 6, 14]
        result = move_generator.non_sliding_moves(7, king)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the top-left corner of the board" do
        king_moves = [57, 49, 48]
        result = move_generator.non_sliding_moves(56, king)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the top-right corner of the board" do
        king_moves = [55, 54, 62]
        result = move_generator.non_sliding_moves(63, king)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the left edge of the board" do
        king_moves = [32, 33, 25, 17, 16]
        result = move_generator.non_sliding_moves(24, king)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the right edge of the board" do
        king_moves = [39, 23, 22, 30, 38]
        result = move_generator.non_sliding_moves(31, king)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the top edge of the board" do
        king_moves = [61, 53, 52, 51, 59]
        result = move_generator.non_sliding_moves(60, king)
        expect(result).to eq(king_moves)
      end

      it "returns all moves from the bottom edge of the board" do
        king_moves = [12, 13, 5, 3, 11]
        result = move_generator.non_sliding_moves(4, king)
        expect(result).to eq(king_moves)
      end

      context "when the King is surrounded by ally pieces" do
        before do
          squares = Array.new(64) { Pawn.new(:white) }
          squares[36] = King.new(:white)
          allow(board).to receive(:squares).and_return(squares)
        end

        it "does not return ally-occupied squares" do
          result = move_generator.non_sliding_moves(36, king)
          expect(result).to be_empty
        end
      end

      context "when the King is surrounded by enemy pieces" do
        before do
          squares = Array.new(64) { Pawn.new(:black) }
          squares[36] = King.new(:white)
          allow(board).to receive(:squares).and_return(squares)
        end

        it "returns enemy-occupied squares" do
          king_moves = [44, 45, 37, 29, 28, 27, 35, 43]
          result = move_generator.non_sliding_moves(36, king)
          expect(result).to eq(king_moves)
        end
      end
    end

    context "when moving a Knight" do
      let(:knight) { Knight.new(:white) }
      let(:squares) { Array.new(64) }

      before do
        allow(board).to receive(:squares).and_return(squares)
      end

      it "returns all moves from the middle of the board" do
        knight_moves = [44, 37, 21, 12, 10, 17, 33, 42]
        result = move_generator.non_sliding_moves(27, knight)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the bottom-left corner of the board" do
        knight_moves = [17, 10]
        result = move_generator.non_sliding_moves(0, knight)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the bottom-right corner of the board" do
        knight_moves = [13, 22]
        result = move_generator.non_sliding_moves(7, knight)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the top-left corner of the board" do
        knight_moves = [50, 41]
        result = move_generator.non_sliding_moves(56, knight)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the top-right corner of the board" do
        knight_moves = [46, 53]
        result = move_generator.non_sliding_moves(63, knight)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the left edge of the board" do
        knight_moves = [41, 34, 18, 9]
        result = move_generator.non_sliding_moves(24, knight)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the right edge of the board" do
        knight_moves = [14, 21, 37, 46]
        result = move_generator.non_sliding_moves(31, knight)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the top edge of the board" do
        knight_moves = [54, 45, 42, 50]
        result = move_generator.non_sliding_moves(60, knight)
        expect(result).to eq(knight_moves)
      end

      it "returns all moves from the bottom edge of the board" do
        knight_moves = [21, 14, 10, 19]
        result = move_generator.non_sliding_moves(4, knight)
        expect(result).to eq(knight_moves)
      end

      context "when the knight is surrounded by ally pieces" do
        before do
          squares = Array.new(64) { Pawn.new(:white) }
          squares[36] = knight.new(:white)
          allow(board).to receive(:squares).and_return(squares)
        end

        it "does not return ally-occupied squares" do
          result = move_generator.non_sliding_moves(36, knight)
          expect(result).to be_empty
        end
      end

      context "when the knight is surrounded by enemy pieces" do
        before do
          squares = Array.new(64) { Pawn.new(:black) }
          squares[36] = knight.new(:white)
          allow(board).to receive(:squares).and_return(squares)
        end

        it "returns enemy-occupied squares" do
          knight_moves = [53, 46, 30, 21, 19, 26, 42, 51]
          result = move_generator.non_sliding_moves(36, knight)
          expect(result).to eq(knight_moves)
        end
      end
    end
  end
end
