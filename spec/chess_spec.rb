# frozen_string_literal: true

require_relative "../lib/chess"
require_relative "../lib/king"
require_relative "../lib/queen"
require_relative "../lib/rook"

describe Chess do
  subject(:chess) { described_class.new }

  let(:squares) { Array.new(128) }
  let(:white_king) { King.new(:white, E1) }
  let(:black_king) { King.new(:black, E8) }
  let(:white_rook) { Rook.new(:white, A1) }
  let(:black_rook) { Rook.new(:black, A8) }

  before do
    board = chess.instance_variable_get(:@board)
    board.instance_variable_set(:@squares, squares)
  end

  describe "#legal_move?" do
    context "when a move is legal" do
      before do
        squares[E1] = white_king
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
        squares[D8] = black_rook
        black_rook.square = D8
      end

      it "returns false" do
        from = E1
        to = D2
        expect(chess.legal_move?(from, to)).to be false
      end
    end

    context "when a piece exposes its king to check" do
      before do
        squares[E1] = white_king
        squares[E2] = white_rook
        white_rook.square = E2
        squares[E8] = black_rook
        black_rook.square = E8
      end

      it "returns false" do
        from = E2
        to = A2
        expect(chess.legal_move?(from, to)).to be false
      end
    end
  end

  describe "#legal_castle?" do
    context "when a kingside castling move is legal" do
      before do
        squares[E1] = white_king
        squares[H1] = white_rook
        white_rook.square = H1
      end

      it "returns true" do
        from = E1
        to = G1
        expect(chess.legal_castle?(from, to)).to be true
      end
    end

    context "when a queenside castling move is legal" do
      before do
        squares[E1] = white_king
        squares[A1] = white_rook
        white_rook.square = A1
      end

      it "returns true" do
        from = E1
        to = C1
        expect(chess.legal_castle?(from, to)).to be true
      end
    end

    context "when the king is in check" do
      before do
        squares[E1] = white_king
        squares[A1] = white_rook
        squares[E8] = black_rook
        black_rook.square = E8
      end

      it "returns false" do
        from = E1
        to = C1
        expect(chess.legal_castle?(from, to)).to be false
      end
    end

    context "when the passed over square is under attack" do
      before do
        squares[E1] = white_king
        squares[A1] = white_rook
        squares[D8] = black_rook
        black_rook.square = D8
      end

      it "returns false" do
        from = E1
        to = C1
        expect(chess.legal_castle?(from, to)).to be false
      end
    end

    context "when the destination square is under attack" do
      before do
        squares[E1] = white_king
        squares[A1] = white_rook
        squares[C8] = black_rook
        black_rook.square = C8
      end

      it "returns false" do
        from = E1
        to = C1
        expect(chess.legal_castle?(from, to)).to be false
      end
    end
  end
end
