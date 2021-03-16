class Bundle < Struct.new(:format_code, :size, :cost)
  def + other
    Bundle.new format_code, size + other.size, cost + other.cost
  end

  def to_s
    "#{size} #{format_code} $%.2f" % cost
  end

  def inspect
    "Bundle['#{format_code}', #{size}, #{cost}]"
  end
end
