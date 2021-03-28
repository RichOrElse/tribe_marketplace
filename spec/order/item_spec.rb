require "spec_helper"

describe Order::Item do
  subject { Order::Item[20, 'IMG'] }

  describe "::to_proc" do
    let(:instance) { ['20', 'IMG'].then(&Order::Item) }

    it "accept strings and returns new instance" do
      expect(instance).to eq subject
    end
  end
end
