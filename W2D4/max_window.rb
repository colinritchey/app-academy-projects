require_relative 'stack_queue.rb'

def bad_solution(array, w) # => O(n^2)

  max_range = 0

  array.each_cons(w) do |window|
    current_range = window.max - window.min

    if current_range > max_range
      max_range = current_range
    end

  end

  max_range

end

def good_solution(array, w)
  max_range = 0

  queue = MinMaxStackQueue.new

  i = 0
  while i < array.length - w do
    queue.enqueue(array[i])
    i += 1
  end



end
