require_relative "spec_helper"


describe MineSweeper do
  
  before :all do
    @games = MineSweeper::start "resources/maps.txt"
  end
  
  
  describe "#start" do
    context "given an existing file path" do
      it "loads games with correct properties" do
        
        game1, game2 = @games[0], @games[1]
        game1.should respond_to :rows, :cols, :map
        game2.should respond_to :rows, :cols, :map
      end  
      
      it "loads the maps correctly" do
        game1, game2 = @games[0], @games[1]
        fields1 = game1.write_fields
        fields1.should eql ["*...", "....", ".*..", "...."]
        fields2 = game2.write_fields
        fields2.should eql ["**...", ".....", ".*..."]
      end
      
    end
    
    context "Given an unexisting file path" do
      it "raises an exception" do
        expect {MineSweeper::start "resources/am.txt"}.to raise_exception
      end
    end
      
  end
  
end