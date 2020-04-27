require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  let(:thermostat) { FactoryBot.create(:thermostat, :reading_here) }
  let(:reading) {thermostat.readings.first}

  it 'returns its location' do
    thermostat.location = "44 Riviera Street"
    expect(thermostat.location).to eq("44 Riviera Street")
  end

  it 'finds and returns a specific reading associated with it' do
    expect(thermostat.readings.find(id=reading.id)).to eq(reading)
  end

  it 'generates and returns a household_token' do
    allow(SecureRandom).to receive(:uuid).and_return('6b8b6c369061498786818825d49ebf06')
    new_thermostat = FactoryBot.create(:thermostat)
    expect(new_thermostat.household_token).to eq ('6b8b6c369061498786818825d49ebf06')
  end
end
