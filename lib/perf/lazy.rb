module Lazy
  @result = [1]

  def self.factorial(num)
    if 0 >= num
      @result[0]
    elsif r = @result[num]
      r
    else
      @result[num] = num * factorial(num - 1)
    end
  end
end
