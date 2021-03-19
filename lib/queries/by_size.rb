class BySize < QueryObject
  def initialize(all)
    super all.sort_by(&:size)
  end

  def combined(total)
    1.upto(max_combinations_within total)
     .flat_map { |length| repeated_combination(length).to_a }
     .find { |combination| combination.sum(&:size) == total } || []
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
