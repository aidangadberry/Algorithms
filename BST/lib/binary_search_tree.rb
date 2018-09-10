require_relative 'bst_node.rb'

class BinarySearchTree
  attr_accessor :root
  
  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
    else
      insert_rec(value, @root)
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?

    if value == tree_node.value
      return tree_node
    elsif value < tree_node.value
      return find(value, tree_node.left)
    else
      return find(value, tree_node.right)
    end
  end

  def delete(value)
    node = find(value)

    unless node.nil?
      par = node.parent

      if node.left.nil? && node.right.nil?
        if node == @root
          @root = nil
        else
          par.value < value ? par.right = nil : par.left = nil
        end
      elsif node.left.nil?
        node.right.parent = par
        par.value < value ? par.right = node.right : par.left = node.left
      elsif node.right.nil?
        node.left.parent = par
        par.value < value ? par.right = node.right : par.left = node.left
      else
        max = maximum(node.left)
        left = max.left
        max.left = node.left
        max.right = node.right
        node.left.parent = max
        node.right.parent = max
        node.parent = max.parent
        max.parent = par
        node.left = left
        par.value < value ? par.right = max : par.left = max
        node.parent.right = node.left
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right.nil?
      return tree_node
    else
      return maximum(tree_node.right)
    end
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?

    child_depths = [
      depth(tree_node.left),
      depth(tree_node.right)
    ]

    return child_depths.max + 1
  end 

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    
   (depth(tree_node.left) - depth(tree_node.right)).abs <= 1 &&
    is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] if tree_node.nil?

    return in_order_traversal(tree_node.left) + [tree_node.value] + in_order_traversal(tree_node.right)
  end


  private
  # optional helper methods go here:

  def insert_rec(value, tree_node)
    if value <= tree_node.value
      if tree_node.left.nil?
        tree_node.left = BSTNode.new(value, tree_node)
      else
        insert_rec(value, tree_node.left)
      end
    else
      if tree_node.right.nil?
        tree_node.right = BSTNode.new(value, tree_node)
      else
        insert_rec(value, tree_node.right)
      end
    end
  end
end
