# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/queen"

describe Queen do
  let(:board) { Board.new }
  let(:squares) { Array.new(128) }

  describe "#moves" do
    context "when a queen is in the middle of an empty board" do
      subject(:queen) { described_class.new(:white, E4) }

      before do
        squares[E4] = queen
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E5, E6, E7, E8, F5, G6, H7, F4, G4, H4, F3, G2, H1,
                          E3, E2, E1, D3, C2, B1, D4, C4, B4, A4, D5, C6, B7,
                          A8]
        expect(queen.moves(board)).to eq(expected_moves)
      end
    end

    context "when a queen is on the edge of an empty board" do
      subject(:queen) { described_class.new(:white, A4) }

      before do
        squares[A4] = queen
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [A5, A6, A7, A8, B5, C6, D7, E8, B4, C4, D4, E4, F4,
                          G4, H4, B3, C2, D1, A3, A2, A1]
        expect(queen.moves(board)).to eq(expected_moves)
      end
    end

    context "when a queen is in the corner of an empty board" do
      subject(:queen) { described_class.new(:white, A1) }

      before do
        squares[A1] = queen
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [A2, A3, A4, A5, A6, A7, A8, B2, C3, D4, E5, F6, G7,
                          H8, B1, C1, D1, E1, F1, G1, H1]
        expect(queen.moves(board)).to eq(expected_moves)
      end
    end

    context "when a queen is surrounded by enemy pieces" do
      subject(:queen) { described_class.new(:white, E4) }

      let(:enemy_piece) { instance_double(Piece) }

      before do
        allow(enemy_piece).to receive(:color).and_return(:black)
        squares[E4] = queen
        squares[E5] = enemy_piece
        squares[F5] = enemy_piece
        squares[F4] = enemy_piece
        squares[F3] = enemy_piece
        squares[E3] = enemy_piece
        squares[D3] = enemy_piece
        squares[D4] = enemy_piece
        squares[D5] = enemy_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E5, F5, F4, F3, E3, D3, D4, D5]
        expect(queen.moves(board)).to eq(expected_moves)
      end
    end

    context "when a queen is surrounded by ally pieces" do
      subject(:queen) { described_class.new(:white, E4) }

      let(:ally_piece) { instance_double(Piece) }

      before do
        allow(ally_piece).to receive(:color).and_return(:white)
        squares[E4] = queen
        squares[E5] = ally_piece
        squares[F5] = ally_piece
        squares[F4] = ally_piece
        squares[F3] = ally_piece
        squares[E3] = ally_piece
        squares[D3] = ally_piece
        squares[D4] = ally_piece
        squares[D5] = ally_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = []
        expect(queen.moves(board)).to eq(expected_moves)
      end
    end
  end
end
