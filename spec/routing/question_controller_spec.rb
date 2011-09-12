require 'spec_helper'

describe QuestionsController do
  context 'routes' do
    it '/questions to questions#index' do
      {:get => '/questions'}.should route_to(:controller => 'questions', :action => 'index')
    end

    it '/questions/new to questions#new' do
      {:get => '/questions/new'}.should route_to(:controller => 'questions', :action => 'new')
    end

    it 'a post request for /questions to questions#create' do
      {:post => '/questions'}.should route_to(:controller => 'questions', :action => 'create')
    end

    it '/questions/show to questions#create' do
      {:get => '/questions/55'}.should route_to(:controller => 'questions', :action => 'show', :id => "55")
    end
  end
end