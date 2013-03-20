class MineReader
  
  attr_accessor :path
  
  def initialize path
    @path = path
  end
  
  def load
     file = File.open @path, 'r'
     game_maps = Parser::parse file.lines
  end
  
  def size
    return 2
  end
  
  
end

private
  class Parser
    require_relative 'mine_sweeper'
    
    def Parser.parse lines
      games = []
      lines.each do |line|
        start_line = line.match(/(\d)+\s+(\d)+\s*$/)
        if start_line
          rows, cols = start_line[1], start_line[2]
          unless rows == "0" && cols == "0"
            games << MineSweeper.new(rows.to_i, cols.to_i)
          end
        else 
          data = line.match(/(\*|\.)+$/)
          games.last.map << data[0].split 
        end  
      end
      return games
    end
    
  end