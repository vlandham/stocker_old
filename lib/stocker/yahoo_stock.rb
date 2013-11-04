require 'nokogiri'
require 'open-uri'

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
      page = Nokogiri::HTML(open(SUMMARY_URL + "?s=#{symbol}"))
    end

  end
end
