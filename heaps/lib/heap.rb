class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
    @store = []
  end

  def count
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @store.length, &@prc)
    val
  end

  def peek
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, @store.length, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    children = []
    ci1 = parent_index * 2 + 1
    ci2 = parent_index * 2 + 2
    children << ci1 if ci1 < len
    children << ci2 if ci2 < len
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index.zero?
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    children = self.child_indices(len, parent_idx).map { |idx| array[idx] }
    sorted = children.sort(&prc)
    
    return array if children.empty?

    if prc.call(array[parent_idx], sorted[0]) > 0
      child_idx = self.child_indices(len, parent_idx)[children.index(sorted[0])]
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      return self.heapify_down(array, child_idx, len, &prc)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx.zero?
    
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    parent_idx = self.parent_index(child_idx)

    if prc.call(array[parent_idx], array[child_idx]) > 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      return self.heapify_up(array, parent_idx, len, &prc)
    end

    array
  end
end