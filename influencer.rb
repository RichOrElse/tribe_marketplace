class Influencer < Struct.new(:bundles)
  def charge(order)
    order.inject(Hash.new(Breakdown.new [])) do |charged, line|
      charged[line.format_code] = Breakdown.new bundles.grep(line)

      charged
    end
  end
end

Bundle = Struct.new(:format_code, :size, :cost)

OrderLine = Struct.new(:size, :format_code) do
  def ===(other)
    size == other.size && format_code == other.format_code
  end
end

Breakdown = Struct.new(:bundles) do
  def total_cost
    bundles.sum(&:cost)
  end

  def total_posts
    bundles.sum(&:size)
  end
end
