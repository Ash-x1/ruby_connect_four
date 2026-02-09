require_relative 'board'

class ConnectFour
  PLAYERS = ['X', 'O']

  def initialize
    @board = Board.new
    @current_player = 0
  end

  def play
    until game_over?
      display_board
      take_turn
      switch_player
    end

    display_board
    end_message
  end

  private

  def take_turn
    column = ask_for_column
    unless @board.drop_piece(column, current_piece)
      puts 'Column full. Try again.'
      take_turn
    end
  end

  def ask_for_column
    puts "Player #{current_piece}, choose a column (0-6):"
    gets.chomp.to_i
  end

  def switch_player
    @current_player = 1 - @current_player
  end

  def current_piece
    PLAYERS[@current_player]
  end

  def game_over?
    @board.winner?('X') ||
      @board.winner?('O') ||
      @board.full?
  end

  def end_message
    if @board.winner?(current_piece)
      puts "Player #{current_piece} wins!"
    else
      puts 'Draw game!'
    end
  end

  def display_board
    puts
    @board.grid.each { |row| puts row.join(' ') }
    puts
  end
end
