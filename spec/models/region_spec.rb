require 'rails_helper'

RSpec.describe Region, type: :model do
    let(:region) { Region.new(name: 'Fake Region')}
    

    it "exitst" do
        Region.new
    end

    describe "attributes" do 
        it "has a name" do
            region = Region.new
            expect(region).to respond_to(:name)
        end
    describe "#to_s" do
        it "returns the name" do
            name = 'Mt.Hood'
            region = Region.new(name: name)
            expect(region.to_s).to eq(name)
        end
    end

    describe "::unspecified" do
        
        it "returns a region with the name 'Unspecified" do
            region = Region.unspecified
            expect(region.name).to eq('Unspeecified')
        end
    end

    describe "association" do
        it "has many tickets" do
            expect(Region.new).to have_many(:tickets)
        end
    end 
     

    describe "validations" do 
        it "cannot have a blank name" do
            region = Region.new(name: 'Fake Region')
            expect(region).to be_valid
        end
end
