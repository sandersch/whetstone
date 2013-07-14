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

  protected

  attr_reader :input
end
