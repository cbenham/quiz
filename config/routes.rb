Quiz::Application.routes.draw do

  resources :questions do
    collection do
      get :answers
    end
  end

  root :to => 'home#index'
end
