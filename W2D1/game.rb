require_relative 'board.rb'
require_relative 'display.rb'

board = Board.new



display = Display.new(board)

# while true do
#   board.display_board
#   board.display.get_input
#   system("clear")
# end


pos = [2,2]
king = King.new(:white, :king, board, pos)
# p board.grid[1][1].color
p king.moves#(:king, pos)

# move_piece([1,0], [2,0])
