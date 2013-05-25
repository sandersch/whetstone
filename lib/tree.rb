module Tree
  class Node
    def initialize(value)
      @value = value
    end

    attr_reader :value, :left, :right

    def insert(child)
      self.left = child
      self.right = child
      self
    end

    def children
      [self.left]
    end

    protected

    attr_writer :left, :right
  end

end
