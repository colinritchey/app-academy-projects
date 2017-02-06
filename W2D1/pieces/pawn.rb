require_relative 'piece.rb'
require_relative '../board.rb'
require_relative 'steppible.rb'

class Pawn < Piece
  include SteppingPiece

  def initialize(color, symbol, board, pos)
    super
  end

  def pawn_diffs
      p_diff = @color == :black ? DELTA_MOVES[:pawn][0] :
                                  DELTA_MOVES[:pawn][1]
      new_moves = p_diff.map do |el|
        [@pos[0] + el[0], @pos[1] + el[1]]
      end

      filter_moves(new_moves)
  end

  def filter_moves(set)
    set.select do |el|
      if el[1] == @pos[1]
        @board[el].symbol == :nothing
      else
        @board[el].color != @color && @board[el].color != :blank
      end
    end
  end

end

board_special = Board.new
pawn = Pawn.new(:black, :pawn, board_special, [1,3])

pawn1 = Pawn.new(:white, :pawn, board_special, [2,2])

# board.grid[2][2] = pawn1

p board_special.grid[2][2]

p pawn.moves
