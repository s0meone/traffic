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
    Feedzirra::Feed.stubs(:fetch_and_parse).raises("do not connect to feed, stub this method")
  end
end


def stub_feed(fixture)
  stub = Feedzirra::Feed.parse(File.read(File.expand_path("../fixtures/#{fixture}", __FILE__)))
  Feedzirra::Feed.stubs(:fetch_and_parse).returns(stub)
end

load File.expand_path('../../lib/traffic.rb', __FILE__)