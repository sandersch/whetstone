module Tree
  class Node
    def initialize(value)
      @value = value
    end

    attr_reader :value, :children

    def insert(child)
      self.children = [child]
      self
    end

    protected

    attr_writer :children
  end

end
