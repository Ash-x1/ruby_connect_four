require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#drop_piece' do
    context 'when column is not full' do
      it 'places the piece in the lowest available row' do
        board.drop_piece(0, 'X')
        board.drop_piece(0, 'O')

        expect(board.grid[5][0]).to eq('X')
        expect(board.grid[4][0]).to eq('O')
      end
    end

    context 'when column is full' do
      it 'returns false' do
        6.times { board.drop_piece(0, 'X') }

        expect(board.drop_piece(0, 'O')).to be false
      end
    end
  end

  describe '#winner?' do
    context 'with horizontal win' do
      it 'returns true' do
        4.times { |i| board.drop_piece(i, 'X') }

        expect(board.winner?('X')).to be true
      end
    end

    context 'with vertical win' do
      it 'returns true' do
        4.times { board.drop_piece(0, 'O') }

        expect(board.winner?('O')).to be true
      end
    end

    context 'with no win' do
      it 'returns false' do
        board.drop_piece(0, 'X')
        board.drop_piece(1, 'O')

        expect(board.winner?('X')).to be false
      end
    end
  end
end
