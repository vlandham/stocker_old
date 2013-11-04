
module Stocker
  class Industry
    def self.from_csv csv_line
    end

    attr_accessor :name, :key, :index, :market_cap, :p_e, :div_yield, :industries_url
    def initialize name
      self.name = name
      self.key = to_key(name)
    end
  end
end
