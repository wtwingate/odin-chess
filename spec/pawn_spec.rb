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

    context "when a white pawn is blocked by an ally piece" do
      subject(:white_pawn) { described_class.new(:white, E2) }

      let(:ally_piece) { instance_double(Piece) }

      before do
        allow(ally_piece).to receive(:color).and_return(:white)
        squares[E2] = white_pawn
        squares[E3] = ally_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = []
        expect(white_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a black pawn is blocked by an ally piece" do
      subject(:black_pawn) { described_class.new(:black, E7) }

      let(:ally_piece) { instance_double(Piece) }

      before do
        allow(ally_piece).to receive(:color).and_return(:black)
        squares[E7] = black_pawn
        squares[E6] = ally_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = []
        expect(black_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a white pawn is blocked by an enemy piece" do
      subject(:white_pawn) { described_class.new(:white, E2) }

      let(:enemy_piece) { instance_double(Piece) }

      before do
        allow(enemy_piece).to receive(:color).and_return(:black)
        squares[E2] = white_pawn
        squares[E3] = enemy_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = []
        expect(white_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a black pawn is blocked by an enemy piece" do
      subject(:black_pawn) { described_class.new(:black, E7) }

      let(:enemy_piece) { instance_double(Piece) }

      before do
        allow(enemy_piece).to receive(:color).and_return(:white)
        squares[E7] = black_pawn
        squares[E6] = enemy_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = []
        expect(black_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a white pawn can capture enemy pieces" do
      subject(:white_pawn) { described_class.new(:white, E2) }

      let(:enemy_piece) { instance_double(Piece) }

      before do
        allow(enemy_piece).to receive(:color).and_return(:black)
        squares[E2] = white_pawn
        squares[D3] = enemy_piece
        squares[F3] = enemy_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E3, E4, D3, F3]
        expect(white_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a black pawn can capture enemy pieces" do
      subject(:black_pawn) { described_class.new(:black, E7) }

      let(:enemy_piece) { instance_double(Piece) }

      before do
        allow(enemy_piece).to receive(:color).and_return(:white)
        squares[E7] = black_pawn
        squares[D6] = enemy_piece
        squares[F6] = enemy_piece
        board.instance_variable_set(:@squares, squares)
      end

      it "returns the correct moves" do
        expected_moves = [E6, E5, F6, D6]
        expect(black_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a white pawn can capture an enemy en passant" do
      subject(:white_pawn) { described_class.new(:white, E2) }

      let(:enemy_pawn) { described_class.new(:black, D7) }

      before do
        squares[E5] = white_pawn
        white_pawn.square = E5
        squares[D5] = enemy_pawn
        enemy_pawn.square = D5
        board.instance_variable_set(:@en_passant, D6)
      end

      it "returns the correct moves" do
        expected_moves = [E6, D6]
        expect(white_pawn.moves(board)).to eq(expected_moves)
      end
    end

    context "when a black pawn can capture an enemy en passant" do
      subject(:black_pawn) { described_class.new(:black, E7) }

      let(:enemy_pawn) { described_class.new(:white, D2) }

      before do
        squares[E4] = black_pawn
        black_pawn.square = E4
        squares[D4] = enemy_pawn
        enemy_pawn.square = D4
        board.instance_variable_set(:@en_passant, D3)
      end

      it "returns the correct moves" do
        expected_moves = [E3, D3]
        expect(black_pawn.moves(board)).to eq(expected_moves)
      end
    end
  end
end
