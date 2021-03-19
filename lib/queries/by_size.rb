class BySize < QueryObject
  def combined(total, length = 1, possible = max_combinations_within(total))
    return [] if length > possible

    repeated_combination(length)
      .find { |combination| combination.sum(&:size) == total } || combined(total, length + 1, possible)
  end

  def breakdowns
    group_by(&:size).map(&Breakdown).reverse
  end

  private

    def max_combinations_within(accumulated_size)
      return 0 if none?

      (accumulated_size / minimum(:size).to_f).ceil
    end
end
