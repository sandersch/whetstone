class Tree
  class Node
    include Comparable

    def initialize(value)
      @value = value
    end

    attr_accessor :value, :left, :right

    def insert(child)
      if self >= child
        self.upsert :left, child
      else
        self.upsert :right, child
      end
    end

    def upsert(side, new_child)
      if existing_child = self.send(side)
        existing_child.insert new_child
      else
        self.send("#{side}=", new_child)
      end
      self
    end

    def <=>(other)
      self.value <=> other.value
    end
  end
end
