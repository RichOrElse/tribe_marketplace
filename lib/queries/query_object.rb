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
end
