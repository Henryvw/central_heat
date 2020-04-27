class Thermostat < ApplicationRecord
  has_many :readings
  before_create :set_auth_household_token

  private
  def set_auth_household_token
    return if household_token.present?
    self.household_token = generate_household_token
  end

  def generate_household_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
