class Breakdown < Struct.new(:total, :size, :cost)
  def to_s
    "\t#{total} x #{size} $%.2f" % cost
  end

  def self.to_proc
    -> size, bundles { new bundles.size, size.to_i, bundles.sum(&:cost) }
  end
end
