require 'rails_helper'

RSpec.describe 'Base API Authentication', type: :request do
  context 'when the user provides a valid API token' do
    let(:thermostat) { FactoryBot.create(:thermostat, :reading_here) }
    it 'authenticates the GET reading request and allows him to access a reading endpoint' do
      reading = thermostat.readings.first
      household_token = thermostat.household_token

      get "/api/v1/readings/#{reading.id}", headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}

      expect(response).to be_successful
    end
  end

  context 'When the user provides an invalid API token' do
    let(:thermostat) { FactoryBot.create(:thermostat, :reading_here) }

    it 'does not allow the user to access the GET reading endpoint' do
      reading = thermostat.readings.first

      get "/api/v1/readings/#{reading.id}", headers: {"HTTP_AUTHORIZATION": "Token token=wrong_token", "ACCEPT": "application/json"}

      expect(response).to have_http_status :unauthorized
    end

    it 'does not allow the user to access the GET thermostat statistics request' do
      reading = thermostat.readings.first
      t_start = reading.created_at - 10.days
      t_end = reading.created_at + 10.days

      get "/api/v1/thermostats/#{thermostat.id}?start=#{t_start}&end=#{t_end}", headers: {"HTTP_AUTHORIZATION": "Token token=wrong_token", "ACCEPT": "application/json"}

      expect(response).to have_http_status :unauthorized
    end

    it 'does not allow the user to access the POST reading request' do
      reading = thermostat.readings.first

      post "/api/v1/readings/", headers: {"HTTP_AUTHORIZATION": "Token token=wrong_token", "ACCEPT": "application/json"}

      expect(response).to have_http_status :unauthorized
    end
  end 
end
