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
  end

end


