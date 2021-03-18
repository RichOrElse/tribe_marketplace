class BySize < QueryObject
  def combined(total, length = 1)
    return [] if length > total

    repeated_combination(length)
      .find { |combination| combination.sum(&:size) == total } || combined(total, length + 1)
  end

  def breakdowns
    group_by(&:size).map(&Breakdown).reverse
  end
end
