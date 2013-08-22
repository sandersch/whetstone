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

  def satisfies_heap_property_at?(idx)
    puts "nodes = #{self.nodes.inspect}"
    self.class.children_of(idx).each do |child|
      @nodes[child] && (@nodes[idx] < @nodes[child] or return false)
    end
    true
  end

  def self.parent_of(idx)
    return nil if idx == 0

    (idx-1) / 2
  end

  def self.children_of(idx)
    [2 * idx + 1, 2 * idx + 2]
  end
end
