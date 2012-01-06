require 'rspec'
require 'simplecov'
require 'fakeweb'
require 'pp'

SimpleCov.start do
  add_group 'Traffic', 'lib/traffic'
  add_group 'Specs', 'spec'
  add_filter __FILE__
end

RSpec.configure do |config|
  config.mock_with :mocha
  
  config.before :each do
    FakeWeb.allow_net_connect = false
  end
end

load File.expand_path('../../lib/traffic.rb', __FILE__)