require 'spec_helper'

describe ResponsesController do
  it 'routes the post request /response to response#create' do
    { :post => '/responses' }.should route_to(:controller => 'responses', :action => 'create')
  end
end