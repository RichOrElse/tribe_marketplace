class Breakdown < Struct.new(:scale, :bundle)
  using CostFormat

  def to_s
    "\t#{scale} x #{bundle.size} #{cost.format}"
  end

  def cost
    scale * bundle.cost
  end

  def size
    scale * bundle.size
  end

  def to_bundle
    scale * bundle
  end

  def empty?
    scale.zero?
  end
end
