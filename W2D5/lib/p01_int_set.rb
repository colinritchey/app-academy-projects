class MaxIntSet

  attr_reader :store, :size

  def initialize(max)
    @store = Array.new(max) {false}
    @size = max
  end

  def insert(num)
    raise "Out of bounds" unless num.between?(0, @size)
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless num.between?(0, @size)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if include?(num)
    @count += 1
    if @count > num_buckets
      resize!
    end

    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.size
  end

  def resize!
    new_int_set = ResizingIntSet.new(num_buckets * 2)

    @store.each do |bucket|
      bucket.each do |el|
        new_int_set.insert(el)
      end
    end

    @store = new_int_set.store
  end

end
