require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  shortest_paths = {}
  possible_paths = PriorityMap.new { |p1, p2| p1[:cost] <=> p2[:cost] }
  possible_paths[source] = { cost: 0, edge: nil }

  until possible_paths.empty?
    vertex, value = possible_paths.extract

    shortest_paths[vertex] = value

    vertex.out_edges.each do |edge|
      next if shortest_paths.key?(edge.to_vertex)
      relax(possible_paths, edge, value[:cost])
    end
  end

  shortest_paths
end

def relax(parents, edge, cost_at_parent)
  to = edge.to_vertex
  cost = cost_at_parent + edge.cost
  unless parents.key?(to) && parents[to][:cost] <= cost
    parents[to] = {
      cost: cost,
      edge: edge
    }
  end
end
