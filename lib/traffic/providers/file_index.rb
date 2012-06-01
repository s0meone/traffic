require 'feedzirra'

module Traffic
  module Providers
    class FileIndex
      RSS_FEED = "http://www.fileindex.nl/rss.php"
      
      def initialize(archived_data=nil)
        @data = Feedzirra::Feed.parse(archived_data) if archived_data
      end
      
      def traffic
        !(rss.description =~ /Er zijn geen files./)
      end
      
      def timestamp
        Time.parse(rss.title.gsub(/Fileindex.nl actuele files /, ""))
      end
      
      def count
        rss.description[/(\d+) files?.+van .+ km./, 1].to_i
      end
      
      def size
        rss.description[/\d+ files?.+van (.+) km./, 1].to_i
      end
      
      def each_item(&block)
        rss.entries.each do |entry|
          item = Struct.new(:road, :from, :to, :from_location, :to_location, :location, :length, :description, :cause, :status).new
          data = entry.title.match /(.+?) van (.+) richting (.+) (.+) km/
          item.road = data[1]
          item.from = data[2]
          item.to = data[3]
          item.length = data[4].to_f

          data = entry.summary.match /(.+) tussen (.+?)( door (.+))? HMP([\d\.]+) .+ HMP([\d\.]+)\s*(.*)/
          if data.nil?
            item.description = entry.summary
          else
            item.description = data[1]
            item.location = data[2]
            item.cause = data[4]
            item.from_location = data[5].to_f
            item.to_location = data[6].to_f
            item.status = data[7]
          end
          
          yield item
        end
      end
      
      private
        def rss
          @data ||= Feedzirra::Feed.fetch_and_parse(RSS_FEED)
        end
    end
  end
end
