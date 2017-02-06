require_relative 'cursor.rb'

class Display
  attr_accessor :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    @board.grid.each_with_index do |row, i|
      new_str = ""
      row.each_with_index do |square, j|
        if [i,j] == @cursor.cursor_pos
          new_str += square.to_s.colorize(:red)
        else
          new_str += square.to_s
        end

      end
      puts new_str
    end
  end

  def get_input
    @cursor.get_input
  end

end
