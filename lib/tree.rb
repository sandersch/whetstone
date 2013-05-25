module Tree
  class Node
    def initialize(value)
      @value = value
    end

    attr_reader :value, :left

    def insert(child)
      self.left = child
      self
    end

    def children
      [self.left]
    end

    protected

    attr_writer :left
  end

end
