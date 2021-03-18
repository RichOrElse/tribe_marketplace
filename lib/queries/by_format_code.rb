class ByFormatCode < QueryObject
  def at(format_code)
    select { |by| by.format_code == format_code }
  end
end
