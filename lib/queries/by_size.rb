class BySize < QueryObject
  def initialize(all)
    super all.sort_by(&:size).reverse!
  end

  def breakdown(total)
    return [] if none? || total <= 0

    (total / first.size.to_f).ceil.downto(0) do |scale|
      head_total = first.size * scale
      tail_total = total - head_total
      breakdowns = tail.breakdown tail_total
      if breakdowns.sum(&:size) == tail_total
        return [Breakdown[scale, first]] + breakdowns
      end
    end

    []
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
