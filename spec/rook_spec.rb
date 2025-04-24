# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/rook"

describe Rook do
  let(:board)   { Board.new }
  let(:squares) { Array.new(128) }

  describe "#moves" do
    context "when a rook is in the middle of an empty board" do
      subject(:rook) { described_class.new(:white, E4) }

      before do
        squares[E4] = rook
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E5, E6, E7, E8, F4, G4, H4, E3, E2, E1, D4, C4, B4,
                          A4]
        expect(rook.moves(board)).to eq(expected_moves)
      end
    end

    context "when a rook is on the edge of an empty board" do
      subject(:rook) { described_class.new(:white, A4) }

      before do
        squares[A4] = rook
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [A5, A6, A7, A8, B4, C4, D4, E4, F4, G4, H4, A3, A2,
                          A1]
        expect(rook.moves(board)).to eq(expected_moves)
      end
    end

    context "when a rook is in the corner of an empty board" do
      subject(:rook) { described_class.new(:white, A1) }

      before do
        squares[A1] = rook
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [A2, A3, A4, A5, A6, A7, A8, B1, C1, D1, E1, F1, G1,
                          H1]
        expect(rook.moves(board)).to eq(expected_moves)
      end
    end

    context "when a rook is surrounded by enemy pieces" do
      subject(:rook) { described_class.new(:white, E4) }

      let(:enemy_piece) { instance_double(Piece) }

      before do
        allow(enemy_piece).to receive(:color).and_return(:black)
        squares[E4] = rook
        squares[E5] = enemy_piece
        squares[F4] = enemy_piece
        squares[E3] = enemy_piece
        squares[D4] = enemy_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E5, F4, E3, D4]
        expect(rook.moves(board)).to eq(expected_moves)
      end
    end

    context "when a rook is surrounded by ally pieces" do
      subject(:rook) { described_class.new(:white, E4) }

      let(:ally_piece) { instance_double(Piece) }

      before do
        allow(ally_piece).to receive(:color).and_return(:white)
        squares[E4] = rook
        squares[E5] = ally_piece
        squares[F4] = ally_piece
        squares[E3] = ally_piece
        squares[D4] = ally_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = []
        expect(rook.moves(board)).to eq(expected_moves)
      end
    end
  end
end
