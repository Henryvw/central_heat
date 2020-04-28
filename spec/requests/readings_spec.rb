require 'sidekiq/testing'



RSpec.describe 'Reading requests', type: :request do
def wait_for
  timeout = 3
  start = Time.now
  x = yield
  until x
    if Time.now - start > timeout
      raise "Wait to long here. Timeout #{timeout} sec"
    end
    sleep(0.1)
    x = yield
  end
end

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

      household_token = thermostat.household_token

      expect {post "/api/v1/readings/?thermostat_id=#{thermostat.id}&humidity=100&battery_charge=100&temperature=100", headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}}.to change(ReadingWorker.jobs, :size).by(1)
    end

    it 'adds a new reading to the database' do
      Sidekiq::Testing.inline!

      household_token = thermostat.household_token

      expect{post "/api/v1/readings/?thermostat_id=#{thermostat.id}&humidity=100&battery_charge=100&temperature=100", headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}}.to change{Reading.count}.by(1)
    end

    xit 'demonstrates STRONG CONSISTENCY during a POST and waits until a new GET request and waits until POST completes' do
      # Even when running Sidekiq in the test environment (sidekiq -e test) I still can't get it to save.
      Sidekiq::Testing.disable!
      household_token = thermostat.household_token
      new_reading_params = {thermostat_id: thermostat.id, humidity: 7000, battery_charge: 7000, temperature:7000}
      new_reading = Reading.new(new_reading_params)
      50.times {post '/api/v1/readings/', params: new_reading_params, headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}}
      binding.pry
      get "/api/v1/readings/96", headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}

      expect(response).to be_successful
      expect(response.body).to include(new_reading.humidity.to_json)
      expect(response.body).to include(new_reading.battery_charge.to_json)
      expect(response.body).to include(new_reading.temperature.to_json)
    end
  end
end
