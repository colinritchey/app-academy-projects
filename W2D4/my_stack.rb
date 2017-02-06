class MyStack
  attr_reader :max, :min

  def initialize
    @store = []
    @max = 0
    @min = 0
  end

  def pop
    @store.pop
  end

  def push(el)
    if empty?
      @max, @min = el, el
    end

    @max = el if el > @max
    @min = el if el < @min
    @store.push(el)
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store.unshift(el)
  end

  def dequeue
    @store.pop
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end
