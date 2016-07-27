require_relative "heap"

class Array
  def heap_sort!
    2.upto(count).each do |length|
      BinaryMinHeap.heapify_up(self, length-1, length)
    end

    count.downto(2).each do |length|
      self[length-1], self[0] = self[0], self[length-1]
      BinaryMinHeap.heapify_down(self, 0, length-1)
    end

    self.reverse!
  end
end
