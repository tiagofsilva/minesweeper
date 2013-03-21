require_relative "mine_reader"

class MineSweeper 
  
  attr_reader :rows, :cols
  attr_accessor :map
  
  def initialize rows=0, cols=0
    @rows, @cols = rows, cols
    @map = []
  end
  
  def MineSweeper.start path
    raise Exception unless File.file? path
    reader = MineReader.new path
    reader.load
  end
  
  def MineSweeper.output_to path, games
    File.open path, 'w' do |file|
      games.each_with_index do |game, i|
        file.puts "\n\n"  if game == games.last
        file.puts "Field ##{i+1}:"
        clues = game.load_clues
        clues.collect do |row|
          row_str = row.inject("") {|result, elem| result + elem.to_s}
          file.write row_str + ((row != clues.last)? "\n" : "") 
        end
        
      end  
    end
    
  end
  
  def write_fields
    @map.inject([]) {|result, elem| result + elem}
  end
  
  def load_clues
    @clues = @map.dup.flatten.map {|str| str.split("").map {|char| char == "."? char = 0 : char}}
    @clues.each_with_index do |row, i|
      row.each_with_index do |char, j|
        if char == "*"
          count_adjacent_mines i, j 
        end
      end
    end
    
    return @clues
  end

  private
  def count_adjacent_mines row, col
    adjacencies = [[row-1, col], [row-1,col+1], [row, col+1], [row+1, col+1], [row+1, col], [row+1, col-1], [row, col-1], [row-1, col-1]] 
    adjacencies.each do |adj|
      if inbounds_map? adj
        x, y = adj[0], adj[1]
        unless @clues[x][y] == "*"
          @clues[x][y] == "0" ? @clues[x][y] = 1 : @clues[x][y] += 1
        end  
      end  
    end
  end
  
  
  def inbounds_map? point
    return point[0] >= 0 && point[0] < @rows && point[1] >= 0 && point[1] < @cols
  end
  
end