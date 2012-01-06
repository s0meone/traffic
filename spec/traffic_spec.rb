require File.expand_path('../spec_helper', __FILE__)

describe Traffic do
  
  describe ".from" do
    it "should raise an exception when using an unknown provider" do
      lambda { Traffic.from(:foobar) }.should raise_error
    end
    
    it "should raise an exception when using an provider with incomplete main attributes" do
      module Traffic
        module Providers
          class EmptyProvider
          end
        end
      end
      lambda { Traffic.from(:empty_provider) }.should raise_error
    end
    
    it "should raise an exception when using an provider with incomplete item attributes" do
      module Traffic
        module Providers
          class EmptyProvider
            attr_accessor *Traffic::MAIN_ATTRIBUTES
            def each_item(&block)
              yield
            end
          end
        end
      end
      lambda { Traffic.from(:empty_provider) }.should raise_error
    end
  end
  
end