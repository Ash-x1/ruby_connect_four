require_relative '../lib/game'

RSpec.describe ConnectFour do
  let(:board) { instance_double(Board) }
  subject(:game) { described_class.new }

  before do
    game.instance_variable_set(:@board, board)
  end

  describe '#play' do
    context 'when a player wins' do
      before do
        allow(board).to receive(:winner?).with('X').and_return(true)
        allow(board).to receive(:winner?).with('O').and_return(false)
        allow(board).to receive(:full?).and_return(false)
        allow(game).to receive(:display_board)
        allow(game).to receive(:end_message)
      end

      it 'ends the game' do
        expect(game).to receive(:end_message)
        game.play
      end
    end
  end
end
