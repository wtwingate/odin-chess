# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/bishop"

describe Bishop do
  let(:board)   { Board.new }
  let(:squares) { Array.new(128) }

  describe "#moves" do
    context "when a bishop is in the middle of an empty board" do
      subject(:bishop) { described_class.new(:white, E4) }

      before do
        squares[E4] = bishop
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [F5, G6, H7, F3, G2, H1, D3, C2, B1, D5, C6, B7, A8]
        expect(bishop.moves(board)).to eq(expected_moves)
      end
    end

    context "when a bishop is on the edge of an empty board" do
      subject(:bishop) { described_class.new(:white, A4) }

      before do
        squares[A4] = bishop
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [B5, C6, D7, E8, B3, C2, D1]
        expect(bishop.moves(board)).to eq(expected_moves)
      end
    end

    context "when a bishop is in the corner of an empty board" do
      subject(:bishop) { described_class.new(:white, A1) }

      before do
        squares[A1] = bishop
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [B2, C3, D4, E5, F6, G7, H8]
        expect(bishop.moves(board)).to eq(expected_moves)
      end
    end

    context "when a bishop is surrounded by enemy pieces" do
      subject(:bishop) { described_class.new(:white, E4) }

      let(:enemy_piece) { instance_double(Piece) }

      before do
        allow(enemy_piece).to receive(:color).and_return(:black)
        squares[E4] = bishop
        squares[F5] = enemy_piece
        squares[F3] = enemy_piece
        squares[D3] = enemy_piece
        squares[D5] = enemy_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [F5, F3, D3, D5]
        expect(bishop.moves(board)).to eq(expected_moves)
      end
    end

    context "when a bishop is surrounded by ally pieces" do
      subject(:bishop) { described_class.new(:white, E4) }

      let(:ally_piece) { instance_double(Piece) }

      before do
        allow(ally_piece).to receive(:color).and_return(:white)
        squares[E4] = bishop
        squares[F5] = ally_piece
        squares[F3] = ally_piece
        squares[D3] = ally_piece
        squares[D5] = ally_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = []
        expect(bishop.moves(board)).to eq(expected_moves)
      end
    end
  end
end
