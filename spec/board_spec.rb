# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  subject(:board) { described_class.new }

  describe "#get_pieces" do
    it "returns all pieces when no color is specified" do
      result = board.get_pieces
      expect(result.length).to eq(32)
    end

    it "returns only white pieces when color is white" do
      result = board.get_pieces(:white)
      expect(result.all? { |piece| piece.color == :white }).to be true
    end

    it "returns only black pieces when color is black" do
      result = board.get_pieces(:black)
      expect(result.all? { |piece| piece.color == :black }).to be true
    end
  end
end
