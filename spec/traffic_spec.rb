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
      
      it "should return a list with info items with the same length as count" do
        @info.items.size.should == @info.count
      end
      
      it "should return a list with info items" do
        @info.items.each { |i| i.class.should == Traffic::InfoItem }
      end
      
      context "the info items in the list" do
        before :each do
          @info_item = @info.items.first
        end
        
        it "should include a from" do
          @info_item.from.should == "Amsterdam"
        end
        
        it "should include a to" do
          @info_item.to.should == "Amersfoort"
        end
        
        it "should include a road number" do
          @info_item.road.should == "A1"
        end
        
        it "should include a length" do
          @info_item.length.should == 2.6
        end
        
        it "should include a description" do
          @info_item.description.should == "Langzaam rijdend verkeer tussen Eemnes en Eembrugge"
        end
        
        it "should include a from location" do
          @info_item.from_location.should == 30.2
        end
        
        it "should include a to location" do
          @info_item.to_location.should == 32.8
        end
      end
    end
  end
  
end