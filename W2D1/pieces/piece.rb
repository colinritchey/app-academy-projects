require_relative 'steppible.rb'
require 'colorize'

class Piece #parent class for all pieces

  attr_reader :color, :symbol, :board, :pos

  def initialize(color, symbol, board, pos)
    @color, @symbol, @board, @pos = color, symbol, board, pos

  end


  def to_s
    case @symbol
    when :knight
      "♘"
    when :king
      "♔"
    when :bishop
      "♝"
    when :queen
      "♕"
    when :rook
      "♖"
    when :pawn
      "♙"
    else
      "_".colorize(:color => :light_blue, :background => :light_gray)
    end
  end
end
