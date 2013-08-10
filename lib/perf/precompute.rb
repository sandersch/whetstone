module Precomputed
  def self.factorial_of(n)
    @result_for[n]
  end

  protected

  def self._compute_factorial(num)
    (1..num).inject(1) { |total, n| total * n }
  end

  @precomputed_values = (1..10000)

  @result_for = @precomputed_values.each_with_object(0 => 1) do |arg, result_for|
    result_for[arg] = arg * result_for[arg - 1]
  end
end
