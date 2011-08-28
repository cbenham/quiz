describe 'routing home' do
  it 'routing / to home#index' do
    { :get => '/'}.should route_to(:controller => 'home', :action => 'index')
  end
end