require File.expand_path('../../spec_helper', __FILE__)

describe Traffic do
  
  describe "::Provider" do
    it "should return a provider class based on a name" do
      Traffic::Provider(:file_index).should == Traffic::Providers::FileIndex
    end
    
    it "should raise an exception when an unknown provider is specified" do
      lambda { Traffic::Provider(:foobar) }.should raise_error
    end
  end
  
end