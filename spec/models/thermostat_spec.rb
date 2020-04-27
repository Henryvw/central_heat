require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  let(:thermostat) { FactoryBot.create(:thermostat) }

  it 'returns its location' do
    thermostat.location = "44 Riviera Street"
    expect(thermostat.location).to eq("44 Riviera Street")
  end
end
