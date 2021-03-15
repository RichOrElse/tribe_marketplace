class Influencer < Struct.new(:bundles)
  def charge(order)
  	Hash.new(Breakdown.new)
  end
end

Bundle = Struct.new(:format_code, :size, :cost)
OrderLine = Struct.new(:quantity, :format_code)
Breakdown = Struct.new(:total_posts, :total_cost, :bundles)

