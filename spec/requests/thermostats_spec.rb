require 'rails_helper'

RSpec.describe 'Thermostat Requests', type: :request do
  let(:thermostat) { FactoryBot.create(:thermostat, :reading_here) }
  let(:reading) {thermostat.readings.first}

  it 'responds successfully to a valid GET thermostat statistics request and supplies access to a thermostat endpoint' do
    reading = thermostat.readings.first
    household_token = thermostat.household_token

    t_start = reading.created_at - 10.days
    t_end = reading.created_at + 10.days
    get "/api/v1/thermostats/#{thermostat.id}?start=#{t_start}&end=#{t_end}", headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}

    expect(response).to be_successful
    expect(response.body).to include(thermostat.assemble_stats(t_start, t_end).to_json)
  end
end
