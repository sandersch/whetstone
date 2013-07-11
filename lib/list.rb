class List
  def initialize(value=nil)
    elements << value if value 
  end

  def contains?(value)
    elements.include? value
  end

  def size
    elements.size
  end

  def add(val)
    elements << val
    self
  end

  protected

  def elements
    @elements ||= []
  end
end
