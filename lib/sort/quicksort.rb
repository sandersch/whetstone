module Quicksort
  def self.sort(input)
    return input if input.length <= 1

    pivot = input.first
    less, greater = input[1..-1].partition { |e| e < pivot }
    self.sort(less) + [pivot] + self.sort(greater)
  end
end
