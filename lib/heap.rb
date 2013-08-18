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

  def self.parent_of(idx)
    (idx/2.0).floor
  end

  def self.children_of(idx)
    [2 * idx, 2 * idx + 1 ]
  end
end
