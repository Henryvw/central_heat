RSpec.describe 'Reading requests', type: :request do
  let(:thermostat) { FactoryBot.create(:thermostat, :reading_here) }

  it 'successfully responds to a GET reading request with the requested reading' do
    reading = thermostat.readings.first
    household_token = thermostat.household_token

    get "/api/v1/readings/#{reading.id}", headers: {"HTTP_AUTHORIZATION": "Token token=#{household_token}", "ACCEPT": "application/json"}

    expect(response).to be_successful
    expect(response.body).to include(reading.to_json)
  end
end
