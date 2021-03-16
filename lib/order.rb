require_relative 'breakdown'

class Order < Struct.new(:bundles)
  def total_cost
    bundles.sum(&:cost)
  end

  def total_posts
    bundles.sum(&:size)
  end

  def with_breakdowns
    bundles.group_by(&:format_code).each_with_object({}) do |(_code, group), with|
      with[group.inject(:+)] = group.group_by(&:size).map(&Breakdown).reverse
    end
  end

  def to_s
    with_breakdowns.flatten.join("\n")
  end
end
