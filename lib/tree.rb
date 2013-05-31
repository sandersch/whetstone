require 'tree/node'

class Tree
  def store(value)
    self.root = Node.new(value)
  end

  def contains?(value)
    root.contains? value
  end

  protected

  attr_accessor :root
end
