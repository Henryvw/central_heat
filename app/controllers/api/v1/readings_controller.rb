module Api
  module V1
    class ReadingsController < Api::V1::BaseController
      def create
      end

      def show
        @reading = Reading.find(params[:id])
      end
    end
  end
end
