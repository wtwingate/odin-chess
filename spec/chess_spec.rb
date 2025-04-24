# frozen_string_literal: true

require_relative "../lib/bishop"
require_relative "../lib/chess"
require_relative "../lib/king"
require_relative "../lib/knight"
require_relative "../lib/pawn"
require_relative "../lib/queen"
require_relative "../lib/rook"

describe Chess do
  subject(:chess) { described_class.new }

  let(:squares) { Array.new(128) }

  before do
    board = chess.instance_variable_get(:@board)
    board.instance_variable_set(:@squares, squares)
  end

  describe "#legal_move?" do
    before do
      squares[E1] = King.new(:white, E1)
    end

    context "when a move is legal" do
      it "returns true" do
        from = E1
        to = E2
        expect(chess.legal_move?(from, to)).to be true
      end
    end

    context "when a move is not legal" do
      it "returns false" do
        from = E1
        to = E3
        expect(chess.legal_move?(from, to)).to be false
      end
    end

    context "when a king moves into check" do
      before do
        squares[D8] = Queen.new(:black, D8)
      end

      it "returns false" do
        from = E1
        to = D2
        expect(chess.legal_move?(from, to)).to be false
      end
    end

    context "when a piece exposes its king to check" do
      before do
        squares[E2] = Rook.new(:white, E2)
        squares[E8] = Rook.new(:black, E8)
      end

      it "returns false" do
        from = E2
        to = A2
        expect(chess.legal_move?(from, to)).to be false
      end
    end
  end

  describe "#legal_castle?" do
    before do
      squares[E1] = King.new(:white, E1)
      squares[A1] = Rook.new(:white, A1)
      squares[H1] = Rook.new(:white, H1)
    end

    context "when a kingside castling move is legal" do
      it "returns true" do
        from = E1
        to = G1
        expect(chess.legal_castle?(from, to)).to be true
      end
    end

    context "when a queenside castling move is legal" do
      it "returns true" do
        from = E1
        to = C1
        expect(chess.legal_castle?(from, to)).to be true
      end
    end

    context "when the king is in check" do
      before do
        squares[E8] = Rook.new(:black, E8)
      end

      it "returns false" do
        from = E1
        to = C1
        expect(chess.legal_castle?(from, to)).to be false
      end
    end

    context "when the passed over square is under attack" do
      before do
        squares[D8] = Rook.new(:black, D8)
      end

      it "returns false" do
        from = E1
        to = C1
        expect(chess.legal_castle?(from, to)).to be false
      end
    end

    context "when the destination square is under attack" do
      before do
        squares[C8] = Rook.new(:black, C8)
      end

      it "returns false" do
        from = E1
        to = C1
        expect(chess.legal_castle?(from, to)).to be false
      end
    end
  end

  describe "#no_legal_moves?" do
    context "when current player has legal moves" do
      before do
        squares[E1] = King.new(:white, E1)
      end

      it "returns false" do
        expect(chess.no_legal_moves?).to be false
      end
    end

    context "when current player has no legal moves" do
      before do
        squares[A1] = King.new(:white, E1)
        squares[B2] = Queen.new(:black, B2)
        squares[C3] = King.new(:black, C3)
      end

      it "returns true" do
        expect(chess.no_legal_moves?).to be true
      end
    end
  end

  describe "#insufficient_material?" do
    before do
      squares[E1] = King.new(:white, E1)
      squares[E8] = King.new(:black, E8)
    end

    context "when there is sufficient material to force checkmate" do
      before do
        squares[E2] = Pawn.new(:white, E2)
      end

      it "returns false" do
        expect(chess.insufficient_material?).to be false
      end
    end

    context "when the material is king vs king" do
      it "returns true" do
        expect(chess.insufficient_material?).to be true
      end
    end

    context "when the material is king vs king + bishop" do
      before do
        squares[A1] = Bishop.new(:white, A1)
      end

      it "returns true" do
        expect(chess.insufficient_material?).to be true
      end
    end

    context "when the material is king vs king + knight" do
      before do
        squares[A1] = Knight.new(:white, A1)
      end

      it "returns true" do
        expect(chess.insufficient_material?).to be true
      end
    end

    context "when the material is king + knight vs king + knight" do
      before do
        squares[A1] = Knight.new(:white, A1)
        squares[H8] = Knight.new(:black, H8)
      end

      it "returns true" do
        expect(chess.insufficient_material?).to be true
      end
    end

    context "when the material is king + knight vs king + bishop" do
      before do
        squares[A1] = Knight.new(:white, A1)
        squares[H8] = Bishop.new(:black, H8)
      end

      it "returns true" do
        expect(chess.insufficient_material?).to be true
      end
    end

    context "when the material is king + bishop vs king + bishop" do
      before do
        squares[A1] = Bishop.new(:white, A1)
        squares[H8] = Bishop.new(:black, H8)
      end

      it "returns true" do
        expect(chess.insufficient_material?).to be true
      end
    end

    context "when the material is king vs king + knight + knight" do
      before do
        squares[A1] = Knight.new(:white, A1)
        squares[A2] = Knight.new(:white, H8)
      end

      it "returns true" do
        expect(chess.insufficient_material?).to be true
      end
    end

    context "when the material is king vs king + bishop + bishop" do
      before do
        squares[A1] = Bishop.new(:white, A1)
        squares[A2] = Bishop.new(:white, A2)
      end

      it "returns false" do
        expect(chess.insufficient_material?).to be false
      end
    end
  end
end
