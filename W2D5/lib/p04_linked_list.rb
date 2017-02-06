class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current = @head

    while current.next != nil
      if current.key == key
        return current.val
      end

      current = current.next
    end

    nil
  end

  def include?(key)
    current = @head

    while current.next != nil
      if current.key == key
        return true
      end

      current = current.next
    end

    false
  end

  def append(key, val)
    current = Link.new(key, val)
    previous_link = last

    previous_link.next = current
    current.prev = previous_link

    current.next = @tail
    @tail.prev = current
  end

  def update(key, val)
    current = @head

    while current.next != nil
      if current.key == key
        current.val = val
        break
      end

      current = current.next
    end

  end

  def remove(key)
    current = @head

    while current.next != nil
      if current.key == key
        current.remove
        break
      end

      current = current.next
    end


  end

  def each

    current = @head

    while current.next != nil
      yield(current) unless current == @head

      current = current.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
