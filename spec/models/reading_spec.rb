require 'rails_helper'

RSpec.describe Reading, type: :model do
  let(:thermostat) { FactoryBot.create(:thermostat, :reading_here) }
  let(:reading) {thermostat.readings.first}

  describe 'Attributes - Classic ActiveRecord Instance Methods' do
    it 'returns the thermostat its associated with' do
      my_thermostat = FactoryBot.create(:thermostat)
      reading.thermostat = my_thermostat
      expect(reading.thermostat).to eq my_thermostat
    end

    it 'returns its temperature' do
      reading.temperature = 45
      expect(reading.temperature).to eq 45
    end

    it 'returns its humidity' do
      reading.humidity = 60
      expect(reading.humidity).to eq 60
    end

    it 'returns its battery charge' do
      reading.battery_charge = 80
      expect(reading.battery_charge).to eq 80
    end

    it 'returns its sequence id' do
      new_reading = FactoryBot.create(:reading, thermostat_id: thermostat.id)
      new_reading.sequential_id = 400
      expect(new_reading.sequential_id).to eq 400
    end
  end
end
