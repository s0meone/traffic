# require all provider source files
Dir[File.expand_path("../providers/**/*.rb", __FILE__)].each {|f| require f}

module Traffic
  def self.Provider(name)
    # camelcase the name
    Traffic::Providers.const_get "#{name.to_s.gsub(/(?:^|_)(.)/) { $1.upcase }}"
  rescue NameError => e
    raise "unknown provider: #{name}"
  end
end

