require 'delegate'

class QueryObject < SimpleDelegator
  def self.to_proc
    method(:new).to_proc
  end

  def tail
    @tail ||= self.class.new drop 1
  end
end
