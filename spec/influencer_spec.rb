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

  describe "#charge" do
    let(:charges) { @influencer.charge([subject]) }

    describe OrderLine[10, 'IMG'] do
      let(:breakdown) { charges['IMG'] }
      specify "10 IMG $800" do
        expect(breakdown.total_posts).to eq 10
        expect(breakdown.total_cost).to eq 800
        expect(breakdown.bundles).to eq [
          Bundle['IMG', 10, 800]
        ]
      end
    end

    describe OrderLine[15, 'FLAC'] do
      let(:breakdown) { charges['FLAC'] }
      specify "15 FLAC $1957.50" do
        expect(breakdown.total_posts).to eq 15
        expect(breakdown.total_cost).to eq 1957.50
        expect(breakdown.bundles).to eq [
          Bundle['FLAC', 9, 1147.50],
          Bundle['FLAC', 6, 810],
        ]
      end
    end

    describe OrderLine[13, 'VID'] do
      let(:breakdown) { charges['IMG'] }
      specify "13 VID $2370" do
        expect(breakdown.total_posts).to eq 13
        expect(breakdown.total_cost).to eq 2370
        expect(breakdown.bundles).to eq [
          Bundle['VID', 5, 1800],
          Bundle['VID', 5, 1800],
          Bundle['VID', 3, 570],
        ]
      end
    end
  end
end
