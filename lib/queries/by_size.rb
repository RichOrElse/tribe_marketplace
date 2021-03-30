class BySize < QueryObject
  def initialize(all)
    super all.sort_by(&:size).reverse!
  end

  def breakdown(total)
    scale_down(total) do |scale|
      head_total = first.size * scale
      tail_total = total - head_total
      breakdowns = tail.breakdown tail_total
      if breakdowns.sum(&:size) == tail_total
        return [Breakdown[scale, first]] + breakdowns
      end
    end

    []
  end

  def scale_down(from, &blk)
    return if from <= 0 || none? || (from % gcd).nonzero?

    (from / first.size.to_f).ceil.downto(0).each(&blk)
  end

  def gcd
    map(&:size).inject(:gcd)
  end
end
