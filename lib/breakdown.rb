class Breakdown < Struct.new(:total, :size, :cost)
  using CostFormat

  def to_s
    "\t#{total} x #{size} #{cost.format}" 
  end

  def self.to_proc
    -> size, bundles { new bundles.size, size.to_i, bundles.sum(&:cost) }
  end
end
