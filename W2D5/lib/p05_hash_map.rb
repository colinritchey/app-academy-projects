require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      @count += 1
      resize! if @count > num_buckets
      bucket(key).append(key, val)
    end

  end

  def get(key)
    bucket(key).get(key)

  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    i = 0
    until i >= num_buckets
      @store[i].each do |el|
        yield(el.key, el.val)
      end
      i += 1
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_hash_map = HashMap.new(num_buckets * 2)

    @store.each_with_index do |bucket, index|
      bucket.each do |el|
        new_hash_map.store[index].append(el.key, el.val)
      end
    end

    @store = new_hash_map.store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
