require_relative "my_stack"

class MinMaxStackQueue
  def initialize
    @store = MyStack.new
    @other_store = MyStack.new
  end

  def enqueue(el)
    until @store.empty?
      @other_store.push(@store.pop)
    end

    @store.push(el)
    
    until @other_store.empty?
      @store.push(@other_store.pop)
    end
  end

  def dequeue
    @store.pop
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def max
    @store.max
  end

  def min
    @store.min
  end
end
