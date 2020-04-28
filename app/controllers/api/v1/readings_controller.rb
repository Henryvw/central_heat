module Api
  module V1
    class ReadingsController < Api::V1::BaseController
      require 'sidekiq/api'
      before_action :validate_params, only: [:create]

      def create
        ReadingWorker.perform_async(reading_params.to_h)
        head :accepted
      end

      def show
        verify_uptodate_thermostat
        @reading = Reading.find(params[:id])
      end

      ActionController::Parameters.action_on_unpermitted_parameters = :raise


      private
      def reading_params
        params.permit(:thermostat_id,
                      :temperature,
                      :humidity,
                      :battery_charge)
      end

      def validate_params
        validate_reading = ReadingValidator.new(reading_params.to_h)
        if !validate_reading.valid?
          render json: { error: validate_reading.errors },
            status: :bad_request
        end
      end
    end
  end
end
