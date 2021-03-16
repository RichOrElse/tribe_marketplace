class Order::Item < Struct.new(:size, :format_code)
  def self.to_proc
    proc { |size, code| new(size.to_i, code) }
  end

  def to_s
    "#{self.class}[#{size}, '#{format_code}']"
  end
end
