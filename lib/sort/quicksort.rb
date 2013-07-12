module Quicksort
  def self.sort(input)
    return input if input.length <= 1

    pivot = input.first
    less, greater = input[1..-1].partition { |e| e < pivot }
    self.sort(less) + [pivot] + self.sort(greater)
  end

  def self.partition(array, left, right, pivot_index)
    pivot = array[pivot_index]

    # move pivot to beginning
    array[pivot_index], array[left] = array[left], array[pivot_index]

    # the first place available to store a value less than the pivot is
    # the position immediately after the pivot itself
    partition_boundary = left + 1

    # walk through the array starting from the element right after the pivot
    # to the last element in our range
    (partition_boundary..right).each do |j|
      if array[j] < pivot
        # move this element to the less than pivot section of the array
        array[j], array[partition_boundary] = array[partition_boundary], array[j]
        partition_boundary += 1
      end
    end

    # move the pivot from the front of the array to the position between the
    # end of the lesser section and the beginning of the greater than section
    array[left], array[partition_boundary - 1] = array[partition_boundary - 1], array[left]

    partition_boundary # return current pivot index
  end
end
