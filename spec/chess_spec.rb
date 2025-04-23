# frozen_string_literal: true

require_relative "../lib/chess"
require_relative "../lib/king"
require_relative "../lib/queen"

describe Chess do
  subject(:chess) { described_class.new }

  let(:squares) { Array.new(128) }
  let(:white_king) { King.new(:white, E1) }
  let(:black_king) { King.new(:black, E8) }
  let(:white_queen) { Queen.new(:white, D1) }
  let(:black_queen) { Queen.new(:black, D8) }

  before do
    board = chess.instance_variable_get(:@board)
    board.instance_variable_set(:@squares, squares)
  end

  describe "#legal_move?" do
    context "when a move is legal" do
      before do
        squares[E1] = white_king
        squares[E8] = black_king
        squares[D1] = white_queen
        squares[D8] = black_queen
      end

      it "returns true" do
        from = E1
        to = E2
        expect(chess.legal_move?(from, to)).to be true
      end
    end

    context "when a move is not legal" do
      before do
        squares[E1] = white_king
        squares[E8] = black_king
        squares[D1] = white_queen
        squares[D8] = black_queen
      end

      it "returns false" do
        from = E1
        to = E3
        expect(chess.legal_move?(from, to)).to be false
      end
    end

    context "when a king moves into check" do
      before do
        squares[E1] = white_king
        squares[E8] = black_king
        squares[D1] = white_queen
        squares[D8] = black_queen
      end

      it "returns false" do
        from = E1
        to = D2
        expect(chess.legal_move?(from, to)).to be false
      end
    end

    context "when a piece exposes its king to check" do
      before do
        squares[A1] = white_king
        white_king.square = A1
        squares[H8] = black_king
        black_king.square = H8
        squares[B2] = white_queen
        white_queen.square = B2
        squares[G7] = black_queen
        black_queen.square = G7
      end

      it "returns false" do
        from = B2
        to = B1
        expect(chess.legal_move?(from, to)).to be false
      end
    end
  end

  describe "#legal_castle" do
    # TODO
  end
end
