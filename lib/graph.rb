class Graph
  def initialize(input)
    @input = input
  end

  def size
    input.size
  end

  def connected?(here, there)
    input[here].include? there
  end

  def neighbors_of(vertex)
    input[vertex]
  end

  def distances_from(starting_vertex)
    distance_to = []
    distance_to[starting_vertex] = 0

    self.bfs starting_vertex do |vertex, neighbor|
      distance_to[neighbor] = distance_to[vertex] + 1
    end

    distance_to
  end

  def bfs(starting_vertex, &block)
    explored = [starting_vertex]
    queue = [starting_vertex]

    while vertex = queue.shift
      neighbors_of(vertex).each do |neighbor|
        if !explored.include? neighbor
          explored << neighbor
          queue << neighbor

          yield vertex, neighbor if block_given?
        end
      end
    end
  end

  protected

  attr_reader :input
end
