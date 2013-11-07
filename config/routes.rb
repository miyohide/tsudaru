Tsudaru::Application.routes.draw do
  resources :tweets, only: [:new, :create, :index]

  root :to => 'tweets#new'

  match "/delayed_job" => DelayedJobWeb, anchor: false
end
