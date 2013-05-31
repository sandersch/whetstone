class Tree
  class << ( EmptyNode = Object.new )
    def upsert(parent, side, new_child)
      parent.send("#{side}=", new_child)
      parent
    end

    def contains?(*)
      false
    end
  end

  class Node
    include Comparable

    def initialize(value)
      @value = value
      @left = EmptyNode
      @right = EmptyNode
    end

    attr_accessor :value, :left, :right

    def contains?(value)
      if self.value == value
        true
      elsif self.value > value
        self.left.contains? value
      else
        self.right.contains? value
      end
    end

    def insert(child, side=nil)
      if self >= child
        self.left.upsert self, :left, child
      else
        self.right.upsert self, :right, child
      end
    end

    def upsert(parent, side, new_child)
      self.insert new_child
    end

    def <=>(other)
      self.value <=> other.value
    end
  end
end
