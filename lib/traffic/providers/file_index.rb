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
      
      private
        def rss
          @data ||= Feedzirra::Feed.fetch_and_parse(RSS_FEED)
        end
    end
  end
end
