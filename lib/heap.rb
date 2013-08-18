class Heap
  def initialize
    @nodes = []
  end

  attr_reader :nodes

  def size
    nodes.size
  end

  def insert(elem)
    @nodes << elem
  end

  def extract_min
    nodes.shift
  end
end
