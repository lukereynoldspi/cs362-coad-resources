require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:region) { create(:region) }
  let (:resource_category) { create(:resource_category) }
  let (:organization) { create(:organization) }

  let (:ticket) { Ticket.new(
    closed: false,
    phone: "1-555-666-2244",
    name: "fake open ticket",
    organization: nil,
    region: region,
    resource_category: resource_category,
  )}

  let (:open_ticket) { Ticket.create!(
    closed: false,
    phone: "1-555-666-2244",
    name: "fake open ticket",
    organization: nil,
    region: region,
    resource_category: resource_category,
  )}

  let (:closed_ticket) { Ticket.create!(
    closed: true,
    phone: "1-555-666-2244",
    name: "fake closed ticket",
    organization: nil,
    region: region,
    resource_category: resource_category,
  )}

  let (:open_ticket_with_organization) { Ticket.create!(
    closed: false,
    phone: "1-555-666-2244",
    name: "fake open ticket with organization",
    organization: organization,
    region: region,
    resource_category: resource_category,
  )}

  let (:closed_ticket_with_organization) { Ticket.create!(
    closed: true,
    phone: "1-555-666-2244",
    name: "fake open ticket with organization",
    organization: organization,
    region: region,
    resource_category: resource_category,
  )}

  describe "validations" do
      
    describe "a ticket has the following" do
      it "has a name" do
        expect(ticket).to be_valid
        ticket.name = nil
        expect(ticket).to be_invalid
      end

      it "has a phone" do
        expect(ticket).to be_valid
        ticket.phone = nil
        expect(ticket).to be_invalid
      end

      it "has a region id" do
        expect(ticket).to be_valid
        ticket.region_id = nil
        expect(ticket).to be_invalid
      end

      it "has a resource category" do
        expect(ticket).to be_valid
        ticket.resource_category_id = nil
        expect(ticket).to be_invalid
      end
    end

    describe "a ticket has a name length" do
      it "has a max length" do
        expect(ticket).to be_valid
        ticket.name = "a" * 256
        expect(ticket).to be_invalid
      end
    end

    describe "a ticket has a description length" do
      it "a description has a max length" do
        expect(ticket).to be_valid
        ticket.description = "a" * 1021
        expect(ticket).to be_invalid
      end
    end

    describe "has a phone" do
      it "has a valid phone number" do
        expect(ticket).to be_valid
        ticket.phone = "invalid fake phone"
        expect(ticket).to be_invalid
      end
    end

  end

  describe "associations" do
      
    it "belongs to a region" do
      ticket { should belong_to(:region) }
    end

    it "belongs to a resource category" do
      ticket { should belong_to(:resource_category) }
    end

    it "belongs to an organization" do
      ticket { should belong_to(:organization) }
    end
  end

  describe "scopes" do
      
    it "returns open tickets from database" do
      results = Ticket.open
      expect(results).to include(open_ticket)
      expect(results).to_not include(closed_ticket)
    end

    it "returns closed tickets from database" do
      results = Ticket.closed
      expect(results).to include(closed_ticket)
      expect(results).to_not include(open_ticket)
    end

    it "returns open tickets for all organizations" do
      results = Ticket.all_organization
      expect(results).to include(open_ticket_with_organization)
      expect(results).to_not include(closed_ticket_with_organization)
    end

    it "returns open tickets of a specific organization" do
      results = Ticket.organization(organization)
      expect(results).to include(open_ticket_with_organization)
      expect(results).to_not include(closed_ticket_with_organization)
    end

    it "returns closed tickets of a specific organization" do
      results = Ticket.closed_organization(organization)
      expect(results).to include(closed_ticket_with_organization)
      expect(results).to_not include(open_ticket_with_organization)
    end

    it "returns ickets of the specific region" do
      results = Ticket.region(region)
      expect(results).to include(open_ticket)
    end

    it "returns tickets category of a specific resource category" do
      results = Ticket.region(resource_category)
      expect(results).to include(open_ticket)
    end

  end

  describe "behaviors" do

    describe "#open?" do
      it "is open" do
        ticket.closed { should be(false) }
        ticket.closed = true
        ticket.closed { should be(true) }
      end
    end

    describe "#captured?" do
      it "is an organization present" do
        ticket.captured? { should be(true) }
        ticket.organization = nil
        ticket.captured? { should be(false) }
      end
    end

    describe "#to_s" do
      it "returns the id" do
        expect(ticket.to_s).to eq("Ticket #{ticket.id}")
        expect(ticket.to_s).to_not eq("Ticket ID")
      end
    end

  end

end
