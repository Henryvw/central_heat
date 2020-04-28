module Api
  module V1
    class ReadingsController < Api::V1::BaseController
      require 'sidekiq/api' 

      def create
        ReadingWorker.perform_async(reading_params.to_h)
        head :accepted
      end

      def show
        verify_uptodate_thermostat
        @reading = Reading.find(params[:id])
      end

      private
      def reading_params
        params.permit(:thermostat_id,
                      :temperature,
                      :humidity,
                      :battery_charge)
      end
    end
  end
end
