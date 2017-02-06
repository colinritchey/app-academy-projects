require_relative 'pieces/piece.rb'
require_relative 'pieces/nullpiece.rb'
require_relative 'pieces/king.rb'
require 'colorize'
require_relative 'display.rb'

class Board
  attr_accessor :grid, :display

  def initialize
    @grid = Array.new(8){ Array.new(8) }
    populate
    @display = Display.new(self)
  end

  def populate
    @grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        self[[i, j]] = King.new(:black, :knight, self, [i,j]) if [0, 1, 6, 7].include?(i)
        self[[i, j]] = NullPiece.instance if [2, 3, 4, 5].include?(i)
      end
    end

  end

  def move_piece(start_pos, end_pos)
    raise "No Piece in start position" if self[start_pos].is_a?(NullPiece)
    raise "Cannot move to the end position" if self[end_pos].is_a?(Piece)
  end

  def [](pos)
    i, j = pos
    @grid[i][j]
  end

  def []=(pos, piece)
    i, j = pos
    @grid[i][j] = piece
  end

  def display_board
    @display.render
  end

  def in_bounds?(pos)
    i, j = pos
    return false unless i.between?(0,7)
    return false unless j.between?(0,7)
    true
  end

end
