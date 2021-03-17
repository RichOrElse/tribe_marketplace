class ByFormatCode < QueryObject
  def at(format_code)
    select { |b| b.format_code == format_code }
  end
end
