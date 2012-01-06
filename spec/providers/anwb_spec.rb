require File.expand_path('../../spec_helper', __FILE__)

describe Traffic do
  
  describe ".from(:anwb)" do
      
    before :each do
      Feedzirra::Feed.stubs(:fetch_and_parse).raises("do not connect to feed, stub this method")
      HTTPClient.any_instance.stubs(:get).raises("do not connect to net, stub this method")
    end
    
    def stub_html(fixture)
      stub = mock(:content => File.read(File.expand_path("../../fixtures/#{fixture}", __FILE__)))
      HTTPClient.any_instance.stubs(:get).returns(stub)
    end

    context "when there is no traffic" do
      before :each do
        stub_html "anwb/empty.html"
        @info = Traffic.from(:anwb)
      end
      
      it "should indicate that there is no traffic" do
        @info.traffic.should_not be_true
      end
    end
    
    context "when there is traffic" do
      before :each do
        stub_html "anwb/traffic.html"
        @info = Traffic.from(:anwb)
      end
      
      it "should indicate that there is traffic" do
        @info.traffic.should be_true
      end
      
      it "should return a timestamp" do
        @info.timestamp.strftime("%H:%M").should == "11:20"
      end
      
      it "should return an info object" do
        @info.class.should == Traffic::Info
      end
 
      it "should be able to return the total size" do
        @info.size.should == 5
      end
      
      it "should be able to return the total count" do
        @info.count.should == 3
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
          @info_item.from.should == "Gouda"
        end
        
        it "should include a to" do
          @info_item.to.should == "Hoek van Holland"
        end
        
        it "should include a road number" do
          @info_item.road.should == "A20"
        end
        
        it "should include a length in km" do
          @info_item.length.should == 0.9
        end
        
        it "should include a description" do
          @info_item.description.should == "A20 Gouda richting Hoek van Holland bij Spaanse Polder is de rechterrijstrook dicht, door een ongeluk."
        end               

        it "should include a from location (hecto markers)" do
          @info_item.from_location.should == 27.9
        end
        
        it "should include a to location" do
          @info_item.to_location.should == 27.0
        end
      end
    end
    
  end
  
end