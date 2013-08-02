class WordTree
  def initialize
    @dict = []
  end

  def store(dict)
    @dict = dict
  end

  def contains?(word)
    @dict.include? word
  end
end
