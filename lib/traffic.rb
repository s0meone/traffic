require File.expand_path("../traffic/version", __FILE__)
require File.expand_path("../traffic/provider", __FILE__)
require File.expand_path("../traffic/info", __FILE__)

module Traffic
  def self.from(provider_name)
    provider = Provider(provider_name).new
    info = Info.new
    
    ATTRIBUTES.each do |attr|
      if provider.respond_to?(attr)
        info.send("#{attr}=", provider.send(attr))
      else
        raise "attribute missing: #{attr}. the selected provider ('#{provider_name}') does not supply all required attributes"
      end
    end
    
    info
  end
end
