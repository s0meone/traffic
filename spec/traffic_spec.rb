require File.expand_path('../spec_helper', __FILE__)

describe Traffic do
  
  describe ".from" do
    it "should raise an exception when using an unknown provider" do
      lambda { Traffic.from(:foobar) }.should raise_error
    end
    
    it "should raise an exception when using an incomplete provider" do
      module Traffic
        module Providers
          class EmptyProvider
          end
        end
      end
      lambda { Traffic.from(:empty_provider) }.should raise_error
    end
    
    context "when there is no traffic" do
      before :each do
        stub_feed "file_index/empty_rss.xml"
        @info = Traffic.from(:file_index)
      end
      
      it "should indicate that there is no traffic" do
        @info.should_not be_traffic
      end
    end
    
    context "when there is traffic" do
      before :each do
        stub_feed "file_index/rss.xml"
        @info = Traffic.from(:file_index)
      end
      
      it "should indicate that there is traffic" do
        @info.should be_traffic
      end
      
      it "should return an info object" do
        @info.class.should == Traffic::Info
      end
      
      it "should be able to return the total size" do
        @info.size.should == 45
      end
      
      it "should be able to return the total count" do
        @info.count.should == 14
      end
    end
  end
  
end