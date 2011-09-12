Quiz::Application.routes.draw do

  resources :questions do
    collection do
      get :answers
    end
  end

  resource :twilio_responses

  root :to => 'home#index'
end
