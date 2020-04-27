FactoryBot.define do
  factory :reading do
    thermostat { nil }
    temperature { 20 }
    humidity { 20 }
    battery_charge {50 }
  end
end
