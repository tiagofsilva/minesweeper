require_relative "mine_reader"

class MineSweeper 
  
  attr_reader :rows, :cols
  attr_accessor :map
  
  def initialize rows=0, cols=0
    @rows, @cols = rows, cols
    @map = []
  end
  
  def MineSweeper.start path
    raise Exception if !File.file? path
    reader = MineReader.new path
    reader.load
  end
  
  def write_fields
    @map.inject([]) {|result, elem| result + elem}
  end
  
end