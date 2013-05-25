module Tree
  class << ( EmptyNode = Class.new )
    def insert_or_initialize(child, parent)
      if child.value <= parent.value
        parent.left = child
      else
        parent.right = child
      end
    end
  end

  class Node
    def initialize(value)
      @value = value
      @left = EmptyNode
      @right = EmptyNode
    end

    attr_reader :value, :left, :right

    def insert_or_initialize(child, parent)
      self.insert(child)
    end

    def insert(child)
      if child.value <= self.value
        self.left.insert_or_initialize child, self
      else
        self.right.insert_or_initialize child, self
      end
      self
    end

    attr_writer :left, :right
  end

end
