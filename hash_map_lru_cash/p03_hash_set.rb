require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    unless include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_new = Array.new(num_buckets * 2) {Array.new}
    count_new = num_buckets * 2
    @store.each do |bucket|
      bucket.each do |value|
        modulo_new = value.hash % count_new
        store_new[modulo_new] << value
      end
    end
    @store = store_new
  end
end
