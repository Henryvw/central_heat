Reading.destroy_all

case Rails.env
when "development"
  unless Thermostat.all.count > 0
    10.times do |index|
      household = Thermostat.create(location: Faker::Address.street_address)
      puts "Created Household with a Thermostat at #{household.location}"
    end
  end

  100.times do |index|
    reading = Reading.create(thermostat_id: Random.rand(Thermostat.first.id..Thermostat.last.id),
                             temperature: Random.rand(-20..50),
                             humidity: Random.rand(0..100),
                             battery_charge: Random.rand(0..100),
                            )
    puts ">>Created Reading on:"
    puts "Household at #{reading.thermostat.location} with Thermostat ID of #{reading.thermostat.id}"
    puts "Temperature: #{reading.temperature} Celsius"
    puts "Humidity: #{reading.humidity} %"
    puts "Battery Charge: #{reading.battery_charge} % <<"
  end
end
