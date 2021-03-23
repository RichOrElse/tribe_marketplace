require 'delegate'

class QueryObject < SimpleDelegator
  def self.to_proc
    method(:new).to_proc
  end

  def minimum(key, *options)
    map(&key).min(*options)
  end

  def maximum(key, *options)
    map(&key).max(*options)
  end

  def repeated_combinations_in(lengths, &blk)
    return to_enum :repeated_combinations_in, lengths if blk.nil?

    lengths.flat_map { |length| repeated_combination(length).map(&blk) }
  end
end
