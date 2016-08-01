class IndexedMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |a, b| a <=> b }
    @index_map = {}
  end

  def count
    store.length
  end

  def extract
    raise "heap is empty" if count < 1
    value = peek

    self.class.swap(store, index_map,  0, count-1)
    index_map.delete(store.pop)
    self.class.heapify_down(store, index_map,  0, store.length, &prc)

    value
  end

  def peek
    raise "heap is empty" if count < 1
    store[0]
  end

  def push(val)
    store.push(val)
    index_map[val] = store.length - 1
    self.class.heapify_up(store, index_map,  count-1, store.length, &prc)
  end

  def reduce(val)
    index = index_map[val]
    self.class.heapify_up(store, index_map, index, &prc)
  end

  protected
  attr_accessor :prc, :store, :index_map

  public
  def self.child_indices(len, parent_index)
    children = []
    index = 2 * parent_index + 1
    return children unless index < len
    children << index
    index += 1
    return children unless index < len
    children << index
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, map, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    idx = parent_idx
    until idx < 0
      idx = sift_down(array, map, idx, len, &prc)
    end
    array
  end

  def self.heapify_up(array, map, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    idx = child_idx
    until idx < 0
      idx = sift_up(array, map, idx, len, &prc)
    end
    array
  end

  private

  def self.sift_down(array, map, parent, len, &prc)
    length = [len, array.length].min
    child1, child2 = child_indices(length, parent);
    return -1 unless child1
    value = array[parent]
    v1 = array[child1]
    call2 = false
    child_swap = false
    if child2
      v2 = array[child2]
      call2 = prc.call(value, v2) > 0
      child_swap = prc.call(v2, v1) < 0
    end
    if prc.call(value, v1) > 0 || call2
      child1 = child2 if child_swap
      if prc.call(value, array[child1]) > 0
        swap(array, map, child1, parent)
        return child1
      end
    end
    -1
  end

  def self.sift_up(array, map, child, len, &prc)
    return -1 if child < 1
    length = [len, array.length].min
    parent = parent_index(child)
    swap(array, map, child, parent) if prc.call(array[parent], array[child]) > 0
    parent
  end

  def self.swap(array, map, idx1, idx2)
    map[array[idx1]] = idx2
    map[array[idx2]] = idx1
    array[idx1], array[idx2] = array[idx2], array[idx1]
  end

end
