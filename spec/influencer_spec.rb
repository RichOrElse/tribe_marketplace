require "spec_helper"

describe Influencer do
  before do
    @influencer = Influencer.new([
      Bundle[ 'IMG',  5, 450],
      Bundle[ 'IMG', 10, 800],
      Bundle['FLAC',  3, 427.50],
      Bundle['FLAC',  6, 810],
      Bundle['FLAC',  9, 1147.50],
      Bundle[ 'VID',  3, 570],
      Bundle[ 'VID',  5, 900],
      Bundle[ 'VID',  9, 1530],
    ])
  end

  describe "#receive" do
    let(:order) { @influencer.receive([subject]) }

    describe Order::Item[10, 'IMG'] do
      specify "10 IMG $800" do
        expect(order.total_posts).to eq 10
        expect(order.total_cost).to eq 800
        expect(order.bundles).to match_array [
          Bundle['IMG', 10, 800]
        ]
      end
    end

    describe Order::Item[15, 'FLAC'] do
      specify "15 FLAC $1957.50" do
        expect(order.total_posts).to eq 15
        expect(order.total_cost).to eq 1957.50
        expect(order.bundles).to match_array [
          Bundle['FLAC', 9, 1147.50],
          Bundle['FLAC', 6, 810],
        ]
      end
    end

    describe Order::Item[13, 'VID'] do
      specify "13 VID $2370" do
        expect(order.total_posts).to eq 13
        expect(order.total_cost).to eq 2370
        expect(order.bundles).to match_array [
          Bundle['VID', 5, 900],
          Bundle['VID', 5, 900],
          Bundle['VID', 3, 570],
        ]
      end
    end

    describe Order::Item[7, 'IMG'] do
      specify "0 IMG $0" do
        expect(order.total_posts).to eq 0
        expect(order.total_cost).to eq 0
        expect(order.bundles).to match_array []
      end
    end

    describe "with 2 Order Items" do
      let(:order) { @influencer.receive [Order::Item[10, 'IMG'], Order::Item[5, 'VID']] }

      specify "10 IMG $800. 5 VID $900" do
        expect(order.total_posts).to eq 15
        expect(order.total_cost).to eq 1700
        expect(order.bundles).to match_array [
          Bundle['IMG', 10, 800],
          Bundle['VID', 5, 900],
        ]
      end
    end

    describe "with 3 Order Items" do
      let(:order) do
        @influencer.receive [
          Order::Item[10, 'IMG'],
          Order::Item[15, 'FLAC'],
          Order::Item[13, 'VID']
        ]
      end

      specify "10 IMG $800. 15 FLAC $1957.50. 13 VID $2370" do
        expect(order.total_posts).to eq 38
        expect(order.total_cost).to eq 5127.50
        expect(order.bundles).to match_array [
          Bundle['IMG', 10, 800],
          Bundle['FLAC', 6, 810],
          Bundle['FLAC', 9, 1147.5],
          Bundle[ 'VID', 3, 570],
          Bundle[ 'VID', 5, 900],
          Bundle[ 'VID', 5, 900],
        ]
        expect(order.with_breakdowns)
          .to include Bundle[ 'IMG', 10, 800] => [
                        Breakdown[1, 10, 800]
                      ],
                      Bundle['FLAC', 15, 1957.50] => [
                        Breakdown[1,  9, 1147.50],
                        Breakdown[1,  6, 810]
                      ],
                      Bundle['VID', 13, 2370] => [
                        Breakdown[2, 5, 1800],
                        Breakdown[1, 3, 570]
                      ]
      end
    end
  end
end
