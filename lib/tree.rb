module Tree
  class Node
    def initialize(value)
      @value = value
    end

    attr_reader :value, :left, :right

    def insert(child)
      if child.value <= self.value
        if self.left
          self.left.insert child
        else
          self.left = child
        end
      else
        if self.right
          self.right.insert child
        else
          self.right = child
        end
      end
      self
    end

    attr_writer :left, :right
  end

end
