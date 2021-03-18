require 'bigdecimal/util'

class Bundle < Struct.new(:format_code, :size, :cost)
  def initialize(format_code, size = 1, cost = 0.0)
    super(format_code, size.to_i, cost.to_d)
  end

  def + other
    Bundle.new format_code, size + other.size, cost + other.cost
  end

  using CostFormat

  def to_s
    "#{size} #{format_code} #{cost.format}"
  end

  def inspect
    "Bundle['#{format_code}', #{size}, #{cost}]"
  end

  def self.to_proc
    -> row { new(*row) }
  end
end
