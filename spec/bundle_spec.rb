require "spec_helper"

describe Bundle do
  subject { Bundle['IMG', 1, 50.5] }

  describe "#to_s" do
    it "renders size format code and cost" do
      expect(subject.to_s).to eq "1 IMG $50.50"
    end
  end
end
