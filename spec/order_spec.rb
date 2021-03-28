require "spec_helper"

describe Order do
  subject { Order.new [[breakdown]] }
  let(:breakdown) { Breakdown[2, bundle]}
  let(:bundle) { Bundle['IMG', 1, 50.5] }

  describe "#to_s" do
    it "renders bundle and breakdown" do
      expect(subject.to_s).to eq "2 IMG $101\n\t2 x 1 $101"
    end
  end
end
