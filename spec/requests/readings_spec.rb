require 'sidekiq/testing'

RSpec.describe 'Reading requests', type: :request do
  let(:thermostat) { FactoryBot.create(:thermostat, :reading_here) }

  it 'successfully responds to a GET reading request with the requested reading' do
    reading = thermostat.readings.first
    household_token = thermostat.household_token

    get "/api/v1/readings/#{reading.id}", headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}

    expect(response).to be_successful
    expect(response.body).to include(reading.to_json)
  end

  context 'when a thermostat posts a new reading to the API' do
    it 'schedules a sidekiq worker' do
      Sidekiq::Testing.fake!

      reading = thermostat.readings.first
      household_token = thermostat.household_token

      expect {post "/api/v1/readings/?thermostat_id=#{thermostat.id}&humidity=100&battery_charge=100&temperature=100", headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}}.to change(ReadingWorker.jobs, :size).by(1)
    end

    it 'adds a new reading to the database' do
      Sidekiq::Testing.inline!

      reading = thermostat.readings.first
      household_token = thermostat.household_token

expect{post "/api/v1/readings/?thermostat_id=#{thermostat.id}&humidity=100&battery_charge=100&temperature=100", headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}}.to change{Reading.count}.by(1)
    end
  end
end
