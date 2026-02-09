class Board
  ROWS = 6
  COLUMNS = 7
  EMPTY = '.'

  attr_reader :grid

  def initialize
    @grid = Array.new(ROWS) { Array.new(COLUMNS, EMPTY) }
  end

  def drop_piece(column, piece)
    row = available_row(column)
    return false unless row

    @grid[row][column] = piece
    true
  end

  def available_row(column)
    (ROWS - 1).downto(0).find { |row| @grid[row][column] == EMPTY }
  end

  def full?
    @grid[0].none? { |cell| cell == EMPTY }
  end

  def winner?(piece)
    horizontal_win?(piece) ||
      vertical_win?(piece) ||
      diagonal_win?(piece)
  end

  private

  def horizontal_win?(piece)
    ROWS.times.any? do |row|
      @grid[row].each_cons(4).any? { |cells| cells.all?(piece) }
    end
  end

  def vertical_win?(piece)
    COLUMNS.times.any? do |col|
      column_cells(col).each_cons(4).any? { |cells| cells.all?(piece) }
    end
  end

  def diagonal_win?(piece)
    diagonals.any? do |diagonal|
      diagonal.each_cons(4).any? { |cells| cells.all?(piece) }
    end
  end

  def column_cells(col)
    ROWS.times.map { |row| @grid[row][col] }
  end

  def diagonals
    diagonals = []

    ROWS.times do |row|
      COLUMNS.times do |col|
        diagonals << collect_diagonal(row, col, 1, 1)
        diagonals << collect_diagonal(row, col, 1, -1)
      end
    end

    diagonals
  end

  def collect_diagonal(row, col, row_step, col_step)
    cells = []

    while row.between?(0, ROWS - 1) && col.between?(0, COLUMNS - 1)
      cells << @grid[row][col]
      row += row_step
      col += col_step
    end

    cells
  end
end
