require 'nokogiri'
require 'open-uri'

require 'stocker/string_util'

module Stocker
  class YahooStock
    SUMMARY_URL= "http://finance.yahoo.com/q"
    KEY_STATISTICS_URL = "http://finance.yahoo.com/q/ks"
    attr_accessor :symbol

    def initialize symbol
      self.symbol = symbol
      @stats = {}
    end

    def key_statistics
      if @stats.empty?
        @stats = parse_key_statistics(self.symbol)
      end
      @stats
    end

    def parse_key_statistics(symbol)
      stats = {}
      page = Nokogiri::HTML(open(KEY_STATISTICS_URL + "?s=#{symbol}"))

      rows = page.css(".yfnc_datamodoutline1 table tr")
      rows.each do |row|
        if row.css("td").size >= 2
          raw_key = row.css("td")[0].text
          raw_value = row.css("td")[1].text

          stats[clean_key(raw_key)] = clean_value(raw_value)
        end
      end
      stats
    end

    def clean_key raw_key
      key = raw_key.strip.gsub(/\d?:/,"").gsub(/\(.*\)/,"")
      key = to_key(key)
      key
    end

    def clean_value raw_value
      raw_value = expand_number(raw_value)
    end

  end
end
