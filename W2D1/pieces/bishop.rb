require_relative 'piece.rb'
require_relative '../board.rb' #dont need this
require_relative 'slidiable.rb'


class Bishop < Piece
  include SlidingPiece

  def initialize(color, symbol, board, pos)
    super
  end

  def move_dirs
    DELTA[:diagonal]
  end

end
