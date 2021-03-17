require 'delegate'

class QueryObject < SimpleDelegator
  def self.to_proc
    method(:new).to_proc
  end
end
