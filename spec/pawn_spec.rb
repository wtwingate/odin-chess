# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/pawn"

describe Pawn do
  let(:board) { Board.new }
  let(:squares) { Array.new(128) }

  describe "#moves" do
    context "when a white pawn is in its starting position" do
      subject(:white_pawn) { described_class.new(:white, E2) }

      before do
        squares[E2] = white_pawn
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E3, E4]
        expect(white_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a black pawn is in its starting position" do
      subject(:black_pawn) { described_class.new(:black, E7) }

      before do
        squares[E7] = black_pawn
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E6, E5]
        expect(black_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a white pawn is not in its starting position" do
      subject(:white_pawn) { described_class.new(:white, E2) }

      before do
        white_pawn.square = E4
        squares[E4] = white_pawn
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E5]
        expect(white_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a black pawn is not in its starting position" do
      subject(:black_pawn) { described_class.new(:black, E7) }

      before do
        black_pawn.square = E5
        squares[E5] = black_pawn
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E4]
        expect(black_pawn.moves(board)).to eq(expected_moves)
      end
    end
  end
end
