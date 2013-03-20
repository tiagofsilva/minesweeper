class MineSweeper 
  
  attr_reader :rows, :cols
  attr_accessor :map
  
  def initialize rows=0, cols=0
    @rows, @cols = rows, cols
    @map = []
  end
  
end