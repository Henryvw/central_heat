FactoryBot.define do
  factory :reading_validator do
    thermostat_id {nil}
    temperature {100}
    humidity {100}
    battery_charge {100}

    initialize_with { ReadingValidator.new(attributes) }
  end
end
