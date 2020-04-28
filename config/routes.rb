Rails.application.routes.draw do
  require 'sidekiq'
require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      scope :readings do
        get '/:id', to: 'readings#show'
        post '/', to: 'readings#create'
      end

      scope :thermostats do
        get '/:id', to: 'thermostats#stats'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
