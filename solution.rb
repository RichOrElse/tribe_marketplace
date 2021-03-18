abort "Invalid input missing format code!" if ARGV.size.odd?

require 'csv'
require_relative 'lib/influencer'

rows = CSV.read("bundles.csv", headers: false)
influencer = Influencer.new(rows.map(&Bundle))

items = ARGV.each_slice(2).map(&Order::Item)
order = influencer.receive items

puts order
