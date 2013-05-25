module Tree
  class Node
    def initialize(value)
      @value = value
    end

    attr_accessor :value, :left, :right

    def insert(child)
      if child.value <= self.value
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
  end
end
