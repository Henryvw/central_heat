module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate

      private
      # For a real / production app I would use OAuth 2 / a safer authentication system
      def authenticate
        authenticate_or_request_with_http_token do |household_token, options|
          Thermostat.find_by(household_token: household_token)
        end
      end

      def current_thermostat
        @current_thermostat ||= authenticate
      end

      def verify_uptodate_thermostat
        if check_workers && check_queue
          puts "Thermostat clear"
        else
          sleep 0.25
          verify_uptodate_thermostat
        end
      end

      def check_queue
        if Sidekiq::Queue.new.size > 0
          Sidekiq::Queue.new.each do |job|
            if job.args[0]["thermostat_id"].to_i == current_thermostat.id
              puts "Jobs in Queue"
              return false
            else
              puts "Queue clear"
              return true
            end
          end
        else
          puts "Queue clear"
          return true
        end
      end

      def check_workers
        puts "Workers check"
        Sidekiq::Workers.new.size < 1
      end
    end
  end
end
