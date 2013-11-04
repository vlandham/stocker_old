require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'stocker/yahoo_stock'

describe YahooStock do

  before(:each) do
    @stock = YahooStock.new('AAPL')
  end

  it "should have a symbol" do
    @stock.symbol.should == 'AAPL'
  end

  it "should have key statistics" do
    stats = @stock.key_statistics
    stats.should_not be_empty
    # stats.each do |key, value|
    #   puts key
    # end
    stats["forward_p_e"].should == 11.0
    stats["market_cap"].should == 467890000000.0

    stats["profit_margin"].should == 0.2167
    stats["qtrly_earnings_growth"].should == -0.086

  end

end


