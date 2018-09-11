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


# Tarjan's

# def topological_sort(vertices)
#   visited = []

#   vertices.each do |vertex|
#     visit(vertex, visited)
#   end

#   visited
# end

# def visit(vertex, visited)
#   return if visited.include?(vertex) || vertex.out_edges.empty?
#   visited << vertex
  
#   vertex.out_edges.each do |edge|
#     return if visited.include?(edge.to_vertex)
#     visit(edge.to_vertex, visited)
#   end

# end