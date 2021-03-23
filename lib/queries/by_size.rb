class BySize < QueryObject
  def initialize(all)
    super all.sort_by(&:size).reverse!
  end

  def combined(total)
    repeated_combinations_in(min_to_max_combinations_within total)
      .find { |combination| combination.sum(&:size) == total } || []
  end

  def breakdowns
    group_by(&:size).map(&Breakdown)
  end

  private

    def min_to_max_combinations_within(size)
      min_combinations_within(size)..max_combinations_within(size)
    end

    def min_combinations_within(accumulated_size)
      return 0 if none?

      (accumulated_size / maximum(:size).to_f).ceil
    end

    def max_combinations_within(accumulated_size)
      return 0 if none?

      (accumulated_size / minimum(:size).to_f).floor
    end
end
