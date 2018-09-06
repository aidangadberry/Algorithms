class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable
  attr_accessor :length

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
    @length = 0
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    first == @tail || last == @head
  end

  def get(key)
    each { |node| return node.val if node.key == key }
  end

  def include?(key)
    each { |node| return true if node.key == key }
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    last.next = node
    node.prev = last
    node.next = @tail
    @tail.prev = node
    @length += 1
  end

  def update(key, val)
    each { |node| node.val = val if node.key == key }
  end

  def remove(key)
    each do |node| 
      if node.key == key
        node.remove 
        @length -= 1
      end
    end
  end

  def each
    curr = first
    until curr == @tail
      yield curr
      curr = curr.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
