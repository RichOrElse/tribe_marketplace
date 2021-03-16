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
    let(:breakdown) { charges[subject.format_code]}

    describe OrderLine[10, 'IMG'] do
      specify "10 IMG $800" do
        expect(breakdown.total_posts).to eq 10
        expect(breakdown.total_cost).to eq 800
        expect(breakdown.bundles).to match_array [
          Bundle['IMG', 10, 800]
        ]
      end
    end

    describe OrderLine[15, 'FLAC'] do
      specify "15 FLAC $1957.50" do
        expect(breakdown.total_posts).to eq 15
        expect(breakdown.total_cost).to eq 1957.50
        expect(breakdown.bundles).to match_array [
          Bundle['FLAC', 9, 1147.50],
          Bundle['FLAC', 6, 810],
        ]
      end
    end

    describe OrderLine[13, 'VID'] do
      specify "13 VID $2370" do
        expect(breakdown.total_posts).to eq 13
        expect(breakdown.total_cost).to eq 2370
        expect(breakdown.bundles).to match_array [
          Bundle['VID', 5, 900],
          Bundle['VID', 5, 900],
          Bundle['VID', 3, 570],
        ]
      end
    end

    describe OrderLine[7, 'IMG'] do
      specify "0 IMG $0" do
        expect(breakdown.total_posts).to eq 0
        expect(breakdown.total_cost).to eq 0
        expect(breakdown.bundles).to match_array []
      end
    end
  end
end
