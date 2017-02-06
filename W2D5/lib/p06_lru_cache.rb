require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(key)
    else
      # prc_key = @prc.call(key)
      calc!(key)
      eject! if count > @max
    end
    # p prc_key
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc ||= Proc.new { |x| x ** 2 }

    val = @prc.call(key)
    @store.append(key,val)

  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    last = @store.last
    a = link.prev
    c = link.next

    a.next = c
    c.prev = a

    link.next = @store.tail
    link.prev = last

    last.next = link
    @store.tail.prev = link

  end

  def eject!
    @store.head.next.remove
  end
end
