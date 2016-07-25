require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize(length = 8)
    @store = StaticArray.new(length)
    @capacity = length
    @length = 0
  end

  # O(1)
  def [](index)
    self.check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    self.check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if length < 1
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length < 1
    value = @store[0]
    i = 1
    while i < @length
      @store[i-1] = @store[i]
      i += 1
    end
    @length -= 1
    value
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.resize! if @length == @capacity
    i = @length
    while i > 0
      @store[i] = @store[i-1]
      i -= 1
    end
    @length += 1
    @store[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index < 0 || index >= @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_store = StaticArray.new(capacity * 2)
    @capacity *= 2
    i = 0
    while i < @length
      new_store[i] = @store[i]
      i += 1
    end
    @store = new_store
  end
end
