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

  def bfs(starting_vertex)
    distance_to = []
    distance_to[starting_vertex] = 0
    queue = [starting_vertex]

    while vertex = queue.shift
      puts "exploring vertex = #{vertex}"

      neighbors_of(vertex).each do |neighbor|
        puts "neighbor = #{neighbor}"

        if !distance_to[neighbor]
          puts "neighbor #{neighbor} is unexplored!"

          distance_to[neighbor] = distance_to[vertex] + 1
          queue << neighbor
        end
      end
    end

    distance_to
  end

  protected

  attr_reader :input
end
