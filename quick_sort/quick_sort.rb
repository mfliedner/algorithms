class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2

    # random pivot, move to front
    idx = rand(array.length)
    array[0], array[idx] = array[idx], array[0]

    pivot = array[0]
    left = []
    right = []

    array[1..-1].each do |el|
      if el < pivot
        left << el
      else
        right << el
      end
    end

    sort1(left).concat([pivot]).concat(sort1(right))
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new { |a, b| a <=> b }

    # random pivot, move to front
    idx = start + rand(length)
    array[start], array[idx] = array[idx], array[start]

    pivot_idx = partition(array, start, length, &prc)
    left = pivot_idx - start
    right = length - left - 1

    sort2!(array, start, left, &prc)
    sort2!(array, pivot_idx+1, right, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    return start if array.length < start + 2

    prc ||= Proc.new { |a, b| a <=> b }
    pivot = array[start]
    pivot_idx = start
    array[start+1...start+length].each_with_index do |el, i|
      idx = i + start + 1
      if prc.call(el, pivot) < 0
        if idx == pivot_idx + 1
          array[idx-1], array[idx] = array[idx], array[idx-1]
        else
          array[pivot_idx] = el
          array[idx] = array[pivot_idx+1]
          array[pivot_idx+1] = pivot
        end
        pivot_idx += 1
      end
    end

    pivot_idx
  end
end
