class TowersOfHanoi
  attr_reader :towers

  def initialize(towers = [[3,2,1], [], []])
    @towers = towers
    @starting_tower = towers.reject{|el| el.empty? }.first
  end

  def won?
    @towers.count { |el| !el.empty? } == 1 && @starting_tower.empty?
  end

  def move(start_pos, end_pos)
    unless [start_pos, end_pos].all? { |i| (0...@towers.size).cover?(i) }
      raise "Tower does not exist"
    end
    raise "Empty starting position" if @towers[start_pos].empty?
    unless @towers[end_pos].empty?
      return if @towers[start_pos].last > @towers[end_pos].last
    end

    @towers[end_pos] << @towers[start_pos].pop
  end

  def play
    puts "Tower Game"

    until won?
      p @towers
      start_pos = gets.chomp.to_i
      end_pos = gets.chomp.to_i
      move(start_pos, end_pos)
    end

    puts "Game Won"
  end

end

if __FILE__ == $PROGRAM_NAME
  TowersOfHanoi.new.play
end
