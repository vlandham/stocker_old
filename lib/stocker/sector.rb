require 'csv'
require 'open-uri'
require 'stocker/string_util'

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
      self.industries_url = "http://biz.yahoo.com/p/#{index}conameu.html"
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
      page = Nokogiri::HTML(open(self.industries_url))
      rows = page.css("table table tr")

      rows.each_with_index do |row, index|
        next if index < 3
        industries << Industry.from_html(row, self)
      end
      industries
    end

    def print
      self.industries.collect {|i| i.print}.join("\n")
    end
  end

  class Industry
    # i cannot get the url from the csv file :(
    def self.from_csv csv_line, sector
      ind = Industry.new(csv_line["Industry"])
      ind.sector = sector
      ind.market_cap = expand_number(csv_line['Market Cap'])
      ind.p_e = expand_number(csv_line["P/E"])
      ind
    end

    def self.from_html row, sector
      ind = Industry.new(row.css('td a')[0].text)
      ind.url = "http://biz.yahoo.com/p/" + row.css('td a')[0]['href']
      ind.sector = sector
      ind.market_cap = expand_number(row.css("td")[2].text)
      ind.p_e = expand_number(row.css("td")[3].text)
      ind.div_yield = expand_number(row.css("td")[5].text)
      ind
    end

    attr_accessor :name, :key, :url, :index, :market_cap, :p_e, :div_yield
    attr_accessor :sector, :sector_name
    def initialize name
      self.name = clean_whitespace(name)
      self.key = to_key(name)
      @symbols = []
    end

    def print
      [self.name, self.key, self.sector.name, self.market_cap].join("\t")
    end

    def symbols
      if @symbols.empty?
        @symbols = parse_symbols self.url
      end
      @symbols
    end

    def parse_symbols url
      symbols = []
      if self.url
        page = Nokogiri::HTML(open(url))
        hrefs = page.css("a").collect {|a| a['href']}
        hrefs.each do |href|
          if href =~ /q\?s=(\S+)&/
            symbols << $1
          end
        end
      end
      symbols
    end
  end
end
