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
    link = @map.get(key)
    val = nil
    if link.nil?
      val = @prc.call(key)
      if count == @max
        eject!
      end
      @store.insert(key, val)
      @map.set(key, @store.last)
    else
      val = link.val
      unless link == @store.last
        @store.remove(key)
        @store.insert(key, val)
        @map.set(key, @store.last)
      end
    end
    val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def eject!
    oldest = @store.first.key
    @store.remove(oldest)
    @map.delete(oldest)
  end
end
