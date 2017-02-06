module SlidingPiece
  DELTA = {
    diagonal:[[1,1], [-1,1],[1,-1],[-1,-1]],
    horizontal: [[0,1],[1,0],[-1,0],[0,-1]]
  }

  def moves
    new_moves = []
    move_dirs.each do |el|
      new_moves += grow_unblocked_moves_in_dir(el[0], el[1])
    end
    p new_moves
    new_moves
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    new_moves = []
    start_x, start_y = @pos
    possible_move = [start_x + dx, start_y + dy]

    while @board.in_bounds?(possible_move)
      new_moves << possible_move
      break if is_position_ok?(possible_move)

      possible_move = [possible_move[0] + dx, possible_move[1] + dy]
    end

    new_moves
  end

  def is_position_ok?(pos)
    @color != @board[pos].color && @board[pos].color != :blank
  end

end
