require "byebug"

class Board 
    attr_reader :grid
    def initialize
        @grid = Array.new(8){[]}
        populate_grid
    end
    
    def populate_grid
        @grid.each_with_index do |row, i|
            if i == 0 || i == 7
                Board.populate_nonpawn(row, i)
            elsif i == 1 || i == 6
                8.times{ |y| row << Piece.new("Pawn", [i, y])}
            else
                8.times{row << nil}
            end
        end
    end

    def self.populate_nonpawn(arr, x)
        arr << Piece.new("Rook", [x, 0])
        arr << Piece.new("Knight", [x, 1])
        arr << Piece.new("Bishop", [x, 2])
        arr << Piece.new("Queen", [x, 3])
        arr << Piece.new("King", [x, 4])
        arr << Piece.new("Bishop", [x, 5])
        arr << Piece.new("Knight", [x, 6])
        arr << Piece.new("Rook", [x, 7])
    end

    def []=(pos, value)
        x, y = pos
        grid[x][y] = value
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end

    def move_piece(start_pos, end_pos)
        unless self[start_pos]
            raise ArgumentError.new("There is no piece there.")
        end
        if self[end_pos]    
            raise ArgumentError.new("There's already a piece there.") 
        end
        self[end_pos] = self[start_pos]
        self[start_pos] = nil
        self[end_pos].pos = end_pos
    end
    
    private 
    attr_writer :grid
end

class Piece
    NAMES = {"Queen" => "Q", "King" => "K", "Rook" => "R", "Bishop" => "B", "Pawn" => "P", "Knight" => "N"}

    attr_reader :name
    attr_accessor :pos

    def initialize(name, pos)
        @name = name
        @pos = pos
    end

    def single_letter
        NAMES[name]
    end

    def update_position(pos)
        @pos = pos
    end

end

class NullPiece < Piece
end

