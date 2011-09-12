require 'spec_helper'

describe HomeController do

  context 'routes' do
    it '/ to home#index' do
      {:get => ''}.should route_to(:controller => 'home', :action => 'index')
    end

    it '/start to home#start' do
      {:get => '/start'}.should route_to(:controller => 'home', :action => 'start')
    end
  end
end