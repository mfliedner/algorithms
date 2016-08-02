require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

#Kahn's
def kahn_sort(vertices)
  list = []
  sorted = []
  count_set = {}

  vertices.each do |vertex|
    count_set[vertex] = vertex.in_edges.count
    list << vertex if vertex.in_edges.empty?
  end

  until list.empty?
    vertex = list.shift
    sorted << vertex

    vertex.out_edges.each do |edge|
      to = edge.to_vertex
      count_set[to] -= 1
      list << to if count_set[to] == 0
    end
  end

  sorted
end

# Tarjan's
def tarjan_sort(vertices)
  sorted = []
  visited = {}

  vertices.each do |vertex|
    dfs(vertex, sorted, visited) unless visited.include?(vertex)
  end

  sorted
end

def dfs(vertex, sorted, visited)
  visited[vertex] = true

  vertex.out_edges.each do |edge|
    to = edge.to_vertex
    dfs(to, sorted, visited) unless visited.include?(to)
  end

  sorted.unshift(vertex)
end
