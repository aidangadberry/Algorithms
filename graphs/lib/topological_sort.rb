require_relative 'graph'

# Implementing topological sort using both Khan's and Tarjan's algorithms

# Khan's

def topological_sort(vertices)
  queue = []
  order = []

  vertices.each do |vertex|
    queue << vertex if vertex.in_edges.empty?
  end

  until queue.empty?
    curr = queue.shift
    neighbors = []
    curr.out_edges.each {|edge| neighbors << edge.to_vertex }

    curr.out_edges.each {|edge| edge.destroy!}

    neighbors.each do |adj|
      queue << adj unless queue.include?(adj)
    end

    vertices.delete(curr)
    order << curr
  end

  return [] unless order.uniq.length == order.length
  order
end

