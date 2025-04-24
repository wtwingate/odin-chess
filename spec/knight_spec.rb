# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/knight"

describe Knight do
  let(:board) { Board.new }
  let(:squares) { Array.new(128) }

  describe "#moves" do
    context "when a knight is in the middle of an empty board" do
      subject(:knight) { described_class.new(:white, E4) }

      before do
        squares[E4] = knight
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [F6, G5, G3, F2, D2, C3, C5, D6]
        expect(knight.moves(board)).to eq(expected_moves)
      end
    end

    context "when a knight is on the edge of an empty board" do
      subject(:knight) { described_class.new(:white, A4) }

      before do
        squares[A4] = knight
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [B6, C5, C3, B2]
        expect(knight.moves(board)).to eq(expected_moves)
      end
    end

    context "when a knight is in the corner of an empty board" do
      subject(:knight) { described_class.new(:white, A1) }

      before do
        squares[A1] = knight
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [B3, C2]
        expect(knight.moves(board)).to eq(expected_moves)
      end
    end

    context "when a knight is surrounded by enemy pieces" do
      subject(:knight) { described_class.new(:white, E4) }

      let(:enemy_piece) { instance_double(Piece) }

      before do
        allow(enemy_piece).to receive(:color).and_return(:black)
        squares[E4] = knight
        squares[F6] = enemy_piece
        squares[G5] = enemy_piece
        squares[G3] = enemy_piece
        squares[F2] = enemy_piece
        squares[D2] = enemy_piece
        squares[C3] = enemy_piece
        squares[C5] = enemy_piece
        squares[D6] = enemy_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [F6, G5, G3, F2, D2, C3, C5, D6]
        expect(knight.moves(board)).to eq(expected_moves)
      end
    end

    context "when a knight is surrounded by ally pieces" do
      subject(:knight) { described_class.new(:white, E4) }

      let(:ally_piece) { instance_double(Piece) }

      before do
        allow(ally_piece).to receive(:color).and_return(:white)
        squares[E4] = knight
        squares[F6] = ally_piece
        squares[G5] = ally_piece
        squares[G3] = ally_piece
        squares[F2] = ally_piece
        squares[D2] = ally_piece
        squares[C3] = ally_piece
        squares[C5] = ally_piece
        squares[D6] = ally_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = []
        expect(knight.moves(board)).to eq(expected_moves)
      end
    end
  end
end
