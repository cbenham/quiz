Quiz::Application.routes.draw do

  resources :questions do
    collection do
      get :answers
    end
  end

  resource :twilio_responses

  match :start, :controller => 'home', :action => 'start'

  root :to => 'home#index'
end
