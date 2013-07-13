module Quicksort
  def self.sort(input)
    return input if input.length <= 1

    pivot = input.first
    less, greater = input[1..-1].partition { |e| e < pivot }
    self.sort(less) + [pivot] + self.sort(greater)
  end

  def self.sort!(input)
    self.in_place_sort(input)
  end

  def self.in_place_sort(array, left=0, right=array.length-1)
    # don't do anything if we don't have at least one element
    if left < right

      # randomly select a pivot
      pivot_index = rand(left..right)

      # partition the array in place by the pivot
      # returns the resulting index of the pivot value
      pivot_index = partition(array, left, right, pivot_index)

      # sort elements less than the pivot
      self.in_place_sort(array, left, pivot_index - 1)

      # sort elements greater than the pivot
      self.in_place_sort(array, pivot_index + 1, right)
    end
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
    (partition_boundary..right).each do |index|
      if array[index] < pivot
        # move this element to the less than pivot section of the array
        array[index], array[partition_boundary] = array[partition_boundary], array[index]
        partition_boundary += 1
      end
    end

    # move the pivot from the front of the array to the position between the
    # end of the lesser section and the beginning of the greater than section
    array[left], array[partition_boundary - 1] = array[partition_boundary - 1], array[left]

    partition_boundary # return current pivot index
  end
end
