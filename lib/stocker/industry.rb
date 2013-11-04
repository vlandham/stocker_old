
module Stocker
  class Industry
    def self.from_csv csv_line, sector
      ind = Industry.new(csv_line["Industry"])
      ind.sector = sector
      ind
    end

    attr_accessor :name, :key, :index, :market_cap, :p_e, :div_yield, :industries_url
    attr_accessor :sector
    def initialize name
      self.name = name
      self.key = to_key(name)
    end
  end
end
