require 'csv'
require 'open-uri'
require 'stocker/string_util'
require 'stocker/industry'

module Stocker
  SECTORS_URL = "http://biz.yahoo.com/p/csv/s_conameu.csv"
  def self.sectors
    sectors = []

    index = 1
    CSV.new(open(SECTORS_URL), :headers => true).each do |line|
      if !line["Sectors"].strip.empty?
        sector = Sector.from_csv(line, index)
        sectors << sector
        index += 1
      end
    end

    sectors
  end


  # represents the 9 'Cyclical sectors' from
  # http://biz.yahoo.com/p/
  # use industries() to get at the industries sub-list
  class Sector
    def self.from_csv csv_line, index
      sector = Sector.new(csv_line['Sectors'],index)
      sector.market_cap = expand_number(csv_line['Market Cap'])
      sector.p_e = expand_number(csv_line["P/E"])
      sector
    end

    attr_accessor :name, :key, :index, :market_cap, :p_e, :div_yield, :industries_url
    def initialize name, index
      self.name = name
      self.key = to_key(name)
      self.index = index
      self.industries_url = "http://biz.yahoo.com/p/csv/#{index}conameu.csv"
      @industries = []
    end

    def industries
      if @industries.empty?
        @industries = parse_industries
      end
      @industries
    end

    def parse_industries
      industries = []
      CSV.new(open(self.industries_url), :headers => true).each do |line|
        if !line["Industry"].strip.empty?
          industries << Industry.from_csv(line)
        end
      end
      industries
    end
  end
end
