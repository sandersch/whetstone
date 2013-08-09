class WordTree
  def initialize
    @tree = {}
  end

  attr_reader :tree

  def store(dict)
    @tree = dict.group_by { |w| w[0] }.each_with_object({}) do |(first_letter,words), hash| 
      hash[first_letter] = store(remove_first_character_from words)
    end
  end

  def contains?(word)
    !!word.chars.each_with_object(current_dict=tree) do |char|
      current_dict = current_dict[char]
      return false unless current_dict
    end
  end

  private

  def remove_first_character_from(words)
    words.select { |w| w.size > 1 }.map { |w| w[1..-1] }
  end
end
