require 'feedzirra'

module Traffic
  module Providers
    class FileIndex
      RSS_FEED = "http://www.fileindex.nl/rss.php"
      
      def traffic
        rss.description =~ /Er zijn geen files./
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
          item = Struct.new(:road, :from, :to, :from_location, :to_location, :length, :description, :cause, :status).new
          data = entry.title.match /(.+?) van (.+) richting (.+) (.+) km/
          item.road = data[1]
          item.from = data[2]
          item.to = data[3]
          item.length = data[4].to_f

          data = entry.summary.match /(.+) HMP([\d\.]+) .+ HMP([\d\.]+)\s*(.*)/
          item.description = data[1]
          item.from_location = data[2].to_f
          item.to_location = data[3].to_f
          item.status = data[4]
          
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
