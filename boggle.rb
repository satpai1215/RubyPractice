
    #https://gist.github.com/zben/10695320
    
    input = [%w[h e l l],
             %w[s e e o],
             %w[t m e a],
             %w[h i s n]]

subject = Board.new(input)

it 'returns correct words' do
  expect(subject.words).to include("HELLO")
  expect(subject.words).to include("THIS")
  expect(subject.words).to include("LOAN")
end

class Board
  attr_accessor :tiles
  
  def initialize(input)
    @tiles = []
    @words = []
    @input = input
  end
  
  def discover
    populate_tiles
    Word.new(self).discover
  end
  
  def populate_tiles
    @input.each_with_index do |letter_array, i|
      letter_array.each_with_index do |letter, j|
        @tiles << Tile.new(self, i + 1, j + 1, letter)
      end
    end

  end
end

class Word
    attr_accessor :tiles, :board
    
    def initialize(board, tile_array=[])
        @tiles = tile_array
        @board = board
    end
    
    def to_s
        @tiles.map { |tile| tile.letter }.join
    end
    
    def discover
      #find child words, check if they are vallid. for valid words, you run discover on them! 
      #for every valid word, you want to keep them in board.words
      board.words << valid_child_words.select(&:is_word?)
      valid_child_words.map(&:discover)  
    end
    
    def child_words
      possible_next_tiles.map {|tile| self.class.new(@board, @tiles << tile) }
    end
    
    def possible_next_tiles
        tiles.last.neighbors - @tiles
    end
    
    def valid_child_words
      child_words.select(&:has_child_words?)
    end
    
    def is_word?
        dictionary.exists?(to_s) && to_s.length >= 5
    end
    
    def has_child_words?
        !dictionary.starting_with(to_s).empty?
    end
end



class Tile
    
    attr_accessor :board, :letter, :x, :y
    
    def initialize(board, letter, x, y)
        @letter = letter
        @x_pos = x
        @y_pos = y
        @board = board
    end
    
    def neighbors
      board.tiles.select{ |tile| neighbor?(tile)  }
    end
    
    def neighbor?(tile)
      horizontal_neighbor?(tile) || vertical_neighbor?(tile) || diagonal_neighbor?(tile)
    end

    def horizontal_neighbor?(tile)
      (tile.x - x).abs == 1 && tile.y == y
    end

    def vertical_neighbor?(tile)
      (tile.y - y).abs == 1 && tile.x == x
    end

    def diagonal_neighbor?(tile)
      (tile.x - x).abs == 1 && (tile.y - y).abs == 1
    end

end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
# cubes = [
#   ["A", "A", "E", "E", "G", "N"],
#   ["E", "L", "R", "T", "T", "Y"],
#   ["A", "O", "O", "T", "T", "W"],
#   ["A", "B", "B", "J", "O", "O"],
#   ["E", "H", "R", "T", "V", "W"],
#   ["C", "I", "M", "O", "T", "U"],
#   ["D", "I", "S", "T", "T", "Y"],
#   ["E", "I", "O", "S", "S", "T"],
#   ["D", "E", "L", "R", "V", "Y"],
#   ["A", "C", "H", "O", "P", "S"],
#   ["H", "I", "M", "N", "Qu", "U"],
#   ["E", "E", "I", "N", "S", "U"],
#   ["E", "E", "G", "H", "N", "W"],
#   ["A", "F", "F", "K", "P", "S"],
#   ["H", "L", "N", "N", "R", "Z"],
#   ["D", "E", "I", "L", "R", "X"]
# ]