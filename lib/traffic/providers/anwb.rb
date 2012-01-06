require 'httpclient'
require 'nokogiri'

module Traffic
  module Providers
    class Anwb
      HTML_FEED = "http://flitsapp.nl/ios/anwb/"
      
      def traffic
        !(count_info[0].text =~ /Totaal aantal meldingen: 0/)
      end
      
      def timestamp
        Time.parse(count_info[2].text[/Laatste update: (.+) uur/, 1])
      end
      
      def count
        count_info[0].text[/Totaal aantal meldingen: (.+)/, 1].to_i
      end
      
      def size
        count_info[1].text[/Totale lengte: (.+) km/, 1].to_i
      end
      
      def each_item(&block)
        html.css(".message").each do |entry|
          item = Struct.new(*ITEM_ATTRIBUTES).new

          item.road = entry.css("span.roadnumber_a,span.roadnumber_n").text
          data = entry.css("strong.desc_short").text
          item.from = data[/(.*) - (.*)/, 1]
          item.to = data[/(.*) - (.*)/, 2]

          item.description = entry.css("p.desc_long").children.first.text
          hmp = entry.css("p.desc_long span.hmp")
          item.from_location = hmp[1].text.to_f
          item.to_location = hmp[0].text.to_f

          unless entry["class"].include?("roadworks")
            item.length = entry.css("span.km").text.to_f
          else 
            item.length = (hmp[1].text.to_f - hmp[0].text.to_f).abs.round(1)
          end

          yield item
        end
      end
      
      private
        def count_info
          html.css("#count").children.select(&:text?)
        end
      
        def html
          @data ||= Nokogiri::HTML::Document.parse(HTTPClient.new.get(HTML_FEED).content)
        end
    end
  end
end
