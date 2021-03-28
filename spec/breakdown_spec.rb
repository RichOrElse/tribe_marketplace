require "spec_helper"

describe Breakdown do
  subject { Breakdown[2, bundle]}
  let(:bundle) { Bundle['IMG', 1, 50.5] }

  describe "#to_s" do
    it "tabs scale by bundle size and cost" do
      expect(subject.to_s).to eq "\t2 x 1 $101"
    end
  end
end
