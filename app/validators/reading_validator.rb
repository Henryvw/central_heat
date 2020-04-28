class ReadingValidator
  include ActiveModel::Validations

  attr_accessor :temperature, :humidity, :battery_charge, :thermostat_id

  validates :temperature, presence: true
  validates :thermostat_id, presence: true
  validates :humidity, presence: true
  validates :battery_charge, presence: true

  def initialize(params={})
    @thermostat_id = params[:thermostat_id]
    @temperature = params[:temperature]
    @humidity = params[:humidity]
    @battery_charge = params[:battery_charge]
    ActionController::Parameters.new(params).permit(:thermostat_id,:temperature,:humidity,:battery_charge)
  end
end
