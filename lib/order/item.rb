class Order::Item < Struct.new(:size, :format_code).extend NewFromRow
  def initialize(size, format_code)
    super(size.to_i, format_code)
  end

  def to_s
    "#{self.class}[#{size}, '#{format_code}']"
  end
end
