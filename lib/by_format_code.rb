class ByFormatCode < Struct.new(:bundles)
  def by_total_posts(size, length = 1)
    return [] if length > 100

    bundles.repeated_combination(length)
      .find { |batch| batch.sum(&:size) == size } or by_total_posts(size, length + 1)
  end

  def self.[](format_code)
    proc do |bundles|
      new bundles.select { |bundle| bundle.format_code == format_code }
    end
  end
end
