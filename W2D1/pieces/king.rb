require_relative 'piece.rb'
require_relative '../board.rb'
require_relative 'steppible.rb'

class King < Piece
  include SteppingPiece

  def initialize(color, symbol, board, pos)
    super
  end

end
