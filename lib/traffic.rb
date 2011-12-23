require File.expand_path("../traffic/version", __FILE__)
require File.expand_path("../traffic/provider", __FILE__)
require File.expand_path("../traffic/info", __FILE__)

module Traffic
  def self.from(provider_name)
    provider = Provider(provider_name).new
    info = Info.new
    
    MAIN_ATTRIBUTES.each do |attr|
      if provider.respond_to?(attr)
        info.send("#{attr}=", provider.send(attr))
      else
        raise "attribute missing: #{attr}. the selected provider ('#{provider_name}') does not supply all required attributes"
      end
    end
    
    provider.each_item do |item|
      info_item = InfoItem.new
      ITEM_ATTRIBUTES.each do |attr|
        if item.respond_to?(attr)
          info_item.send("#{attr}=", item.send(attr))
        else
          raise "attribute missing: #{attr}. the selected provider item ('#{provider_name}') does not supply all required attributes"
        end
      end
      info.items << info_item
    end
    
    info
  end
end
