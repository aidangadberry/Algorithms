class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    
    pivot = array[0]
    left = []
    right = []

    array.drop(1).each do |el|
      if el > pivot
        right << el
      else
        left << el
      end
    end

    self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1
    
    piv_idx = self.partition(array, start, length, &prc)
    self.sort2!(array, start, piv_idx - start, &prc)
    self.sort2!(array, piv_idx + 1, length - piv_idx - 1, &prc)
  end
  
  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot = array[start]
    part_idx = start
    
    (length - 1).times do |num|
      idx = start + num + 1
      
      if (prc.call(array[idx], pivot) < 0)
        array[idx], array[part_idx + 1] = array[part_idx + 1], array[idx]
        part_idx += 1
      end
    end

    array[start], array[part_idx] = array[part_idx], array[start]
    part_idx
  end
end