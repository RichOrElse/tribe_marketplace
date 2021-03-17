class ByTotalPosts < QueryObject
  def at(size, length = 1)
    return [] if length > 100

    repeated_combination(length)
      .find { |batch| batch.sum(&:size) == size } or at(size, length + 1)
  end
end
