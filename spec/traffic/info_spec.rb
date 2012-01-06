require File.expand_path('../../spec_helper', __FILE__)

describe Traffic do
  describe "Info" do
    it "should have a traffic presence tester" do
      item = Traffic::Info.new
      item.traffic = true
      item.traffic?.should be_true
    end
  end
  
  describe "InfoItem" do
    
    it "should have presence testers" do
      item = Traffic::InfoItem.new
      Traffic::ITEM_ATTRIBUTES.each do |attr|
        item.send("#{attr}=", "foobar")
        item.send("#{attr}?").should be_true
        item.send("#{attr}=", nil)
        item.send("#{attr}?").should be_false
      end
    end
    
  end
end