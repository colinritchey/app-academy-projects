module SteppingPiece
  DELTA_MOVES = {

    king: [[0,1], [1,1], [1,0], [0,-1], [1,-1], [-1,1], [-1,-1], [-1,0]],
    knight: [[1,2], [2,1], [2,-1], [1, -2], [-1,-2], [-2,-1], [-2,1], [-1,2]],
    pawn: [
      [[1,1], [1,0], [1,-1]],
      [[-1,-1], [-1,0], [-1,1]]
    ]
  }

  def moves
    move_diffs.select {|el| is_position_ok?(el)}
  end

  def move_diffs
    return pawn_diffs if @symbol == :pawn
    DELTA_MOVES[@symbol].map do |el|
      [@pos[0] + el[0], @pos[1] + el[1]]
    end
  end

  def is_position_ok?(pos)
    @board.in_bounds?(pos) && @color != @board[pos].color
  end


end
