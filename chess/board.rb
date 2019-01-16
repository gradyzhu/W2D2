require "byebug"
require_relative "display"
require_relative "piece"

class Board
    attr_reader :grid
    def initialize
        @grid = Array.new(8){[]}
        populate_grid
    end
    
    def populate_grid
        @grid.each_with_index do |row, i|
            if i == 0
                populate_nonpawn(row, i, :white)
            elsif i == 7
                populate_nonpawn(row, i, :black)
            elsif i == 1
                8.times{ |y| row << Pawn.new([i, y], self, :white)}
            elsif i == 6
                8.times{ |y| row << Pawn.new([i, y], self, :black)}
            else
                8.times{row << NullPiece.instance}
            end
        end
    end

    def populate_nonpawn(arr, x, col)
        arr << Rook.new([x, 0], self, col)
        arr << Knight.new([x, 1], self, col)
        arr << Bishop.new([x, 2], self, col)
        arr << Queen.new([x, 3], self, col)
        arr << King.new([x, 4], self, col)
        arr << Bishop.new([x, 5], self, col)
        arr << Knight.new([x, 6], self, col)
        arr << Rook.new([x, 7], self, col)
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


