require_relative "spec_helper"

describe MineReader do
  
  before :each do
    @reader = MineReader.new "resources/maps.txt"
  end
  
  describe "#load" do
    it "loads a game_map for each mine field" do
      games = @reader.load
      games.size.should eql 2
    end
    
  end
end