require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize(length = 8)
    @store = StaticArray.new(length)
    @capacity = length
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    self.check_index(index)
    @store[ring_index(index)]
  end

  # O(1)
  def []=(index, value)
    self.check_index(index)
    @store[ring_index(index)] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if length < 1
    val = self[@length-1]
    @length -= 1
    val
  end

  # O(1) ammortized
  def push(val)
    self.resize! if @length == @capacity
    @length += 1
    self[@length-1] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if length < 1
    value = self[0]
    @start_idx = ring_index(1)
    @length -= 1
    value
  end

  # O(1) ammortized
  def unshift(val)
    self.resize! if @length == @capacity
    @start_idx = ring_index(-1)
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index < 0 || index >= @length
  end

  def ring_index(index)
    (@start_idx + index) % @capacity
  end

  def resize!
    new_size = capacity * 2
    new_store = StaticArray.new(capacity * 2)
    i = 0
    while i < @length
      new_store[i] = self[i]
      i += 1
    end
    @capacity = new_size
    @store = new_store
    @start_idx = 0
  end
end
