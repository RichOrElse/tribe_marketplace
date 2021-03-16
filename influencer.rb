class Influencer < Struct.new(:bundles)
  def initialize(bundles)
    super(bundles.extend Bundles)
  end

  def charge(order)
    order.inject(Hash.new(Breakdown.new [])) do |charged, line|
      charged[line.format_code] = Breakdown.new bundles.fetch(line)
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
  def fetch(line, found = [])
    biggest = select(&HasFormatCode[line]).sort_by(&:size)

    size = line.size
    bundle = biggest.pop

    while size > 0
      return found unless bundle

      found << bundle
      size -= bundle.size

      bundle = biggest.pop if size < bundle.size
    end

    found
  end

  HasFormatCode = proc do |line|
    proc { |other| line.format_code == other.format_code }
  end
end
