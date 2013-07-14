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

  protected

  attr_reader :input
end
