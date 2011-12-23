module Traffic
  MAIN_ATTRIBUTES = [:timestamp, :count, :size, :traffic]
  Info = Struct.new(*MAIN_ATTRIBUTES) do
    def traffic?
      !traffic
    end
    
    def items
      @items ||= []
    end
  end
  
  ITEM_ATTRIBUTES = [:road, :from, :to, :from_location, :to_location, :location, :length, :description, :cause, :status]
  InfoItem = Struct.new(*ITEM_ATTRIBUTES)
end