require_relative 'piece.rb'
require_relative '../board.rb' #dont need this
require_relative 'slidiable.rb'


class Queen < Piece
  include SlidingPiece

  def initialize(color, symbol, board, pos)
    super
  end

  def move_dirs
    DELTA[:diagonal] + DELTA[:horizontal]
  end

end

queen = Queen.new(:white, :queen, Board.new, [2,2])

p queen.moves.length
