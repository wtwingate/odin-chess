# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/king"
require_relative "../lib/rook"

describe King do
  subject(:king) { described_class.new(:white, E1) }

  let(:board) { Board.new }
  let(:squares) { Array.new(128) }

  describe "#in_check?" do
    context "when the king is in check" do
      let(:enemy_rook) { Rook.new(:black, E8) }

      before do
        squares[E1] = king
        squares[E8] = enemy_rook
        board.instance_variable_set(:@squares, squares)
      end

      it "returns true" do
        expect(king).to be_in_check(board)
      end
    end

    context "when the king is not in check" do
      let(:enemy_rook) { Rook.new(:black, D8) }

      before do
        squares[E1] = king
        squares[D8] = enemy_rook
        board.instance_variable_set(:@squares, squares)
      end

      it "returns false" do
        expect(king).not_to be_in_check(board)
      end
    end
  end

  describe "#moves" do
    context "when a king is in the middle of an empty board" do
      subject(:king) { described_class.new(:white, E4) }

      before do
        squares[E4] = king
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E5, F5, F4, F3, E3, D3, D4, D5]
        expect(king.moves(board)).to eq(expected_moves)
      end
    end

    context "when a king is on the edge of an empty board" do
      subject(:king) { described_class.new(:white, A4) }

      before do
        squares[A4] = king
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [A5, B5, B4, B3, A3]
        expect(king.moves(board)).to eq(expected_moves)
      end
    end

    context "when a king is in the corner of an empty board" do
      subject(:king) { described_class.new(:white, A1) }

      before do
        squares[A1] = king
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [A2, B2, B1]
        expect(king.moves(board)).to eq(expected_moves)
      end
    end

    context "when a king is surrounded by enemy pieces" do
      subject(:king) { described_class.new(:white, E4) }

      let(:enemy_piece) { instance_double(Piece) }

      before do
        allow(enemy_piece).to receive(:color).and_return(:black)
        squares[E4] = king
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
        expect(king.moves(board)).to eq(expected_moves)
      end
    end

    context "when a king is surrounded by ally pieces" do
      subject(:king) { described_class.new(:white, E4) }

      let(:ally_piece) { instance_double(Piece) }

      before do
        allow(ally_piece).to receive(:color).and_return(:white)
        squares[E4] = king
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
        expect(king.moves(board)).to eq(expected_moves)
      end
    end

    context "when a white king is able to castle" do
      subject(:white_king) { described_class.new(:white, E1) }

      let(:queenside_rook) { Rook.new(:white, A1) }
      let(:kingside_rook) { Rook.new(:white, H1) }

      before do
        squares[E1] = white_king
        squares[A1] = queenside_rook
        squares[H1] = kingside_rook
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E2, F2, F1, D1, D2, C1, G1]
        expect(white_king.moves(board)).to eq(expected_moves)
      end
    end

    context "when a black king is able to castle" do
      subject(:black_king) { described_class.new(:black, E8) }

      let(:queenside_rook) { Rook.new(:black, A8) }
      let(:kingside_rook) { Rook.new(:black, H8) }

      before do
        squares[E8] = black_king
        squares[A8] = queenside_rook
        squares[H8] = kingside_rook
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [F8, F7, E7, D7, D8, C8, G8]
        expect(black_king.moves(board)).to eq(expected_moves)
      end
    end
  end
end
