require 'rails_helper'

RSpec.describe ReadingValidator do
  context "when a thermostat id is not given" do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    subject { build :reading_validator, thermostat_id: nil }
    it { is_expected.not_to be_valid }
  end

  context "when a thermostat id is given" do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    subject { build :reading_validator, thermostat_id: thermostat.id }
    it { is_expected.to be_valid }
  end

  context "when a temperature is not given" do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    subject { build :reading_validator, thermostat_id: thermostat.id, temperature: nil }
    it { is_expected.not_to be_valid }
  end

  context "when a temperature is given" do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    subject { build :reading_validator, thermostat_id: thermostat.id }
    it { is_expected.to be_valid }
  end

  context "when a humidity is not given" do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    subject { build :reading_validator, thermostat_id: thermostat.id, humidity: nil }
    it { is_expected.not_to be_valid }
  end

  context "when a humidity is given" do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    subject { build :reading_validator, thermostat_id: thermostat.id }
    it { is_expected.to be_valid }
  end

  context "when a battery charge is not given" do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    subject { build :reading_validator, thermostat_id: thermostat.id, battery_charge: nil }
    it { is_expected.not_to be_valid }
  end

  context "when a thermostat id is given" do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    subject { build :reading_validator, thermostat_id: thermostat.id }
    it { is_expected.to be_valid }
  end



end

