require 'nokogiri'
require 'open-uri'

class YahooStock

  @stats = {}
  @symbol

  def initialize symbol
    self.symbol = symbol
  end

  def key_statistics
    if @stats.empty?
      parse_key_statistics
    end
    @stats
  end

  def parse_key_statistics
  end

end
