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
  
  describe "#load_clues" do
    
    let(:adj) {[["*", 1, 0, 0], [1, 1, 0, 0]]}
    let(:game) {MineSweeper::start("resources/maps1.txt").first} 
    let(:adj2) {[["*", "*", 1, 0, 0], [3, 3, 2, 0, 0], [1, "*", 1, 0, 0]]}
    let(:game2) {MineSweeper::start("resources/maps2.txt").first}  
    
    it "responds to the method" do
      game1 = @games.first
      game1.should respond_to :load_clues
    end
    
    it "counts number of mines in a map with only one mine " do
      game.load_clues.should eql adj
    end
    
    it "counts number of mines in a map with more than one mine" do
      game2.load_clues.should eql adj2
    end

  end
  
  describe "#output_to" do
    context "when receives a valid result" do
      let(:games) {MineSweeper::start "resources/maps.txt"}
      
      it "writes an output that matches the file" do
        MineSweeper::output_to "resources/clues_compare.txt", games
        File.open "resources/clues.txt", 'r' do |file|
          str1 = file.read
          str2 = File.open("resources/clues_compare.txt", 'r').read
          str1.should == str2 
        end
      end
    end
  end

  
  
end