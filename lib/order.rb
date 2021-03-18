require_relative 'breakdown'

class Order < Struct.new(:lines)
  def bundles
    lines.flatten
  end

  def total_cost
    bundles.sum(&:cost)
  end

  def total_posts
    bundles.sum(&:size)
  end

  def with_breakdowns
    lines.each_with_object({}) do |line, with|
      with[line.reduce(:+)] = line.then(&BySize).breakdowns
    end
  end

  def to_s
    with_breakdowns.flatten.join("\n")
  end
end
