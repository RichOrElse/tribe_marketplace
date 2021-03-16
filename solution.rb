require_relative 'lib/influencer'

influencer = Influencer.new([
  Bundle[ 'IMG',  5, 450],
  Bundle[ 'IMG', 10, 800],
  Bundle['FLAC',  3, 427.50],
  Bundle['FLAC',  6, 810],
  Bundle['FLAC',  9, 1147.50],
  Bundle[ 'VID',  3, 570],
  Bundle[ 'VID',  5, 900],
  Bundle[ 'VID',  9, 1530],
])

items = ARGV.each_slice(2).map(&Order::Item)
order = influencer.receive items

puts order
