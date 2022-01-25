require 'rails_helper'

RSpec.describe Region, type: :model do

  it "exists" do
    Region.new
  end

  describe "attributes" do
    it "has a name" do
      region = Region.new
      expect(region).to respond_to(:name)
    end
  end

  describe "#to_s" do
    it "returns the same" do
      name = 'Mt. Hood'
      region = Region.new(name: name)
      expect(region.to_s).to eq(name)
    end
  end

end
