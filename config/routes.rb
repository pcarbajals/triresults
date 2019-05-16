Rails.application.routes.draw do
  resources :racers do
    post 'entries' => 'racers#create_entry'
  end

  resources :races

  namespace :api do
    get 'races' => 'races#index'
    get 'races/:id' => 'races#show'
    get 'races/:id/results' => 'races#results'
    get 'races/:id/results/:id' => 'races#results_index'

    get 'racers' => 'racers#index'
    get 'racers/:id' => 'racers#show'
    get 'racers/:id/entries' => 'racers#entries'
    get 'racers/:id/entries/:id' => 'racers#entries_index'
  end
end
