# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Quiz::Application.initialize!

Haml::Template.options[:format] = :html5
