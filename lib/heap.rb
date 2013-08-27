class Heap
  def initialize
    @nodes = []
  end

  attr_reader :nodes

  def size
    nodes.size
  end

  def insert(elem)
    idx = @nodes.size
    @nodes[idx] = elem
    bubble_up_from idx
  end

  def bubble_up_from(idx)
    while parent_idx = self.class.parent_of(idx)
      if satisfies_heap_property_at? parent_idx
        return idx
      else
        swap idx, parent_idx
        idx = parent_idx
      end
    end
    idx
  end

  def swap(idx1, idx2)
    @nodes[idx1], @nodes[idx2] = @nodes[idx2], @nodes[idx1]
  end

  def extract_min
    nodes.shift
  end

  def satisfies_heap_property_at?(idx)
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
