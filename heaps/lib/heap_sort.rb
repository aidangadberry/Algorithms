require_relative "heap"

class Array
  def heap_sort!
    idx = self.length - 1
    prc = Proc.new { |el1, el2| -1 * el1 <=> el2 }

    while idx >= 0
      BinaryMinHeap.heapify_down(self, idx, self.length, &prc)
      idx -= 1
    end

    idx = 0

    while idx < self.length
      BinaryMinHeap.heapify_up(self, 0, self.length)
      idx += 1
    end
  end
end
