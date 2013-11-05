require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'stocker/sector'


describe Sector do

  before(:each) do
    @sectors = Stocker.sectors
  end

  it "should have sectors" do
    @sectors.should_not be_empty
    @sectors[0].name.should == "Basic Materials"
    @sectors[0].key.should == "basic_materials"
  end

  it "should have market cap" do
    @sectors[0].market_cap.should be_within(100000000.0).of(233233.3 * 1000000000.0)
  end

  it "should print" do
    @sectors[0].print.split("\n")[0].should include("Agricultural Chemicals")
  end

  it "should have industries" do
    @sectors[0].industries.should_not be_empty
    ind = @sectors[0].industries[0]
    ind.sector.should == @sectors[0]
    ind.name.should == "Agricultural Chemicals"
    ind.print.split("\t")[0].should ==  "Agricultural Chemicals"
  end

  it "should have industry symbols" do
    ind = @sectors[0].industries[0]
    ind.symbols.should include("agu")
  end

end
