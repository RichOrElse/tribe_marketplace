require 'bigdecimal/util'

class Bundle < Struct.new(:format_code, :size, :cost).extend NewFromRow
  def initialize(format_code, size = 1, cost = 0.0)
    super(format_code, size.to_i, cost.to_d)
  end

  def + other
    Bundle.new format_code, size + other.size, cost + other.cost
  end

  def * scale
    Bundle.new format_code, size * scale, cost * scale
  end

  def coerce(scale)
    [self, scale]
  end

  using CostFormat

  def to_s
    "#{size} #{format_code} #{cost.format}"
  end
end
