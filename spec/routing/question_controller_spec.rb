require 'spec_helper'

describe QuestionsController do
  it 'routes /questions to questions#index' do
    { :get => '/questions' }.should route_to(:controller => 'questions', :action => 'index')
  end

  it 'routes /questions/new to questions#new' do
    { :get => '/questions/new' }.should route_to(:controller => 'questions', :action => 'new')
  end

  it 'routes a post request for /questions to questions#create' do
    { :post => '/questions' }.should route_to(:controller => 'questions', :action => 'create')
  end

  it 'routes /questions/show to questions#create' do
    { :get => '/questions/55' }.should route_to(:controller => 'questions', :action => 'show', :id => "55")
  end
end