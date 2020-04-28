module Api
  module V1
    class ThermostatsController < Api::V1::BaseController

      def stats
        verify_uptodate_thermostat
        household = Thermostat.find(params[:id])
        @household_stats_for_timeframe = household.assemble_stats(params[:start], params[:stop])
      end
    end
  end
end
