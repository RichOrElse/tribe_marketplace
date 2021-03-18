require_relative 'bundle'
require_relative 'order'
require_relative 'order/item'
require_relative 'queries/query_object'
require_relative 'queries/by_format_code'
require_relative 'queries/by_size'

class Influencer
  def initialize(bundles)
    @bundles_for = Hash.new do |bundles_for, item|
      bundles_for[item] = bundles.then(&ByFormatCode).at(item.format_code)
                                 .then(&BySize).combined(item.size)
    end
  end

  def receive(items)
    Order.new items.map(&@bundles_for)
  end
end
