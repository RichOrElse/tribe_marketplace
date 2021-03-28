require_relative 'breakdown'

class Order < Struct.new(:lines)
  def total_cost
    lines.flatten.sum(&:cost)
  end

  def total_posts
    lines.flatten.sum(&:size)
  end

  def with_breakdowns
    lines.each_with_object({}) do |breakdowns, with|
      with[breakdowns.map(&:to_bundle).reduce(:+)] = breakdowns
    end
  end

  def to_s
    with_breakdowns.flatten.join("\n")
  end
end
