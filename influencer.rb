class Influencer
  def initialize(bundles)
    @by_format_code = bundles.group_by(&:format_code)
                             .each { |_, group| group.extend Bundles }

    @bundles_for = Hash.new do |bundles_for, item|
      bundles_for[item] = @by_format_code[item.format_code].by_total_posts(item.size)
    end
  end

  def receive(items)
    Order.new items.flat_map(&@bundles_for)
  end
end

Bundle = Struct.new(:format_code, :size, :cost)

class Order < Struct.new(:bundles)
  Item = Struct.new(:size, :format_code)

  def total_cost
    bundles.sum(&:cost)
  end

  def total_posts
    bundles.sum(&:size)
  end
end

module Bundles
  def by_total_posts(size, length = 1)
    return [] if length > 100

    repeated_combination(length)
      .find { |batch| batch.sum(&:size) == size } or by_total_posts(size, length + 1)
  end
end
