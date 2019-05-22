Rails.application.routes.draw do
  resources :racers do
    post 'entries' => 'racers#create_entry'
  end

  resources :races

  namespace :api do
    get 'races'                      => 'races#index'
    get 'races/:race_id'             => 'races#show'
    get 'races/:race_id/results'     => 'races#results'
    get 'races/:race_id/results/:id' => 'races#results_index'

    post 'races' => 'races#create'

    put 'races/:race_id' => 'races#update'

    delete 'races/:race_id' => 'races#destroy'

    get 'racers'                       => 'racers#index'
    get 'racers/:racer_id'             => 'racers#show'
    get 'racers/:racer_id/entries'     => 'racers#entries'
    get 'racers/:racer_id/entries/:id' => 'racers#entries_index'
  end
end
