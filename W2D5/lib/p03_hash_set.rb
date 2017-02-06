require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return self[key.hash] if include?(key)
    @count += 1
    if count > num_buckets
      resize!
    end
    self[key.hash] << key
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    self[key.hash].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_hash_set = HashSet.new(num_buckets * 2)

    @store.each do |bucket|
      bucket.each do |el|
        new_hash_set.insert(el)
      end
    end

    @store = new_hash_set.store
  end
end
