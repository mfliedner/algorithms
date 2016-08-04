require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    @map = {}
    @queue = IndexedMinHeap.new { |a, b| prc.call(@map[a], @map[b]) }
  end

  def [](key)
    @map[key]
  end

  def []=(key, value)
    if @map.key?(key)
      update(key, value)
    else
      insert(key, value)
    end
  end

  def count
    @queue.count
  end

  def empty?
    @queue.count < 1
  end

  def extract
    key = @queue.extract
    value = @map.delete(key)
    [key, value]
  end

  def key?(key)
    @map.key?(key)
  end

  def has_key?(key)
    @map.key?(key)
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    @map[key] = value
    queue.push(key)
  end

  def update(key, value)
    @map[key] = value
    queue.reduce(key)
  end
end
