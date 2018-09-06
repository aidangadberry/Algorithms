require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.get(key)
      update_node!(@map[key])
    else
      calc!(key)
    end
    @store.last.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    p "calc"
    eject! if @store.length == @max
    node = @store.append(key, @prc.call(key))
    @map.set(key, node)
  end

  def update_node!(node)
    p node
    @store.remove(node)
    @store.append(node.key, node.val)
  end

  def eject!
    p "ejecting"
    @map[@store.first.key] = nil
    @store.first.remove
  end
end
