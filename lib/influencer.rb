require_relative 'bundle'
require_relative 'order'
require_relative 'order/item'
require_relative 'by_format_code'

class Influencer
  def initialize(bundles)
    @by_format_code = Hash.new do |by, format_code|
      by[format_code] = bundles.yield_self(&ByFormatCode[format_code])
    end

    @bundles_for = Hash.new do |bundles_for, item|
      bundles_for[item] = @by_format_code[item.format_code].by_total_posts(item.size)
    end
  end

  def receive(items)
    Order.new items.flat_map(&@bundles_for)
  end
end
