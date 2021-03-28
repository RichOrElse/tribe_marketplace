require_relative 'new_from_row'
require_relative 'cost_format'
require_relative 'bundle'
require_relative 'order'
require_relative 'order/item'
require_relative 'queries/query_object'
require_relative 'queries/by_format_code'
require_relative 'queries/by_size'

class Influencer
  def initialize(bundles)
    @breakdowns_for = Hash.new do |breakdowns_for, item|
      breakdowns_for[item] = bundles.then(&ByFormatCode).at(item.format_code)
                                    .then(&BySize).breakdown(item.size).reject(&:empty?)
    end
  end

  def receive(items)
    Order.new items.map(&@breakdowns_for).reject(&:empty?)
  end
end
