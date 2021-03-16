class Influencer < Struct.new(:bundles)
  def initialize(bundles)
    @bundles_for = bundles.group_by(&:format_code)
                          .each { |_, group| group.extend Bundles }
    super
  end

  def charge(order)
    order.inject(Hash.new(Breakdown.new [])) do |charged, line|
      charged[line.format_code] = Breakdown.new(
        @bundles_for[line.format_code].by_total_posts(line.size)
      )
      charged
    end
  end
end

Bundle = Struct.new(:format_code, :size, :cost)

OrderLine = Struct.new(:size, :format_code)

Breakdown = Struct.new(:bundles) do
  def total_cost
    bundles.sum(&:cost)
  end

  def total_posts
    bundles.sum(&:size)
  end
end

module Bundles
  def by_total_posts(size, length = 1)
    repeated_combination(length)
      .find { |batch| batch.sum(&:size) == size } or by_total_posts(size, length + 1)
  end
end
