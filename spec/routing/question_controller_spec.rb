require 'spec_helper'

describe QuestionsController do
  it 'routes /questions to question#index' do
    { :get => '/questions' }.should route_to(:controller => 'questions', :action => 'index')
  end

  it 'routes /questions/new to question#new' do
    { :get => '/questions/new' }.should route_to(:controller => 'questions', :action => 'new')
  end

  it 'routes /questions/create to question#create' do
    { :post => '/questions' }.should route_to(:controller => 'questions', :action => 'create')
  end
end