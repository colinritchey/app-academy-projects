require_relative 'piece.rb'
require_relative '../board.rb' #dont need this
require_relative 'slidiable.rb'
class Rook < Piece
  include SlidingPiece

  def initialize(color, symbol, board, pos)
    super
  end

  def move_dirs
    DELTA[:horizontal]
  end

end
