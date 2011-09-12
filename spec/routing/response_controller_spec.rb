require 'spec_helper'

describe TwilioResponsesController do
  it 'routes the post request /response to response#create' do
    { :post => '/twilio_responses' }.should route_to(:controller => 'twilio_responses', :action => 'create')
  end
end