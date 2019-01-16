require "colorize"
require_relative "cursor"
require_relative "board"
require "byebug"

class Display  
    attr_accessor :possible_moves, :board
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
        @possible_moves = []
    end
  
    def render
        puts("  " + %w(0 1 2 3 4 5 6 7).join("  "))
        cursor.board.grid.each_with_index do |row, i|
            print("#{i} ")
            row.each_with_index do |el, j|
                if [i, j] == cursor.cursor_pos
                    cursor.selected ? color = :red : color = :yellow
                elsif possible_moves.include?([i, j])
                    color = :red
                elsif i % 2 == j % 2
                    color = :light_blue
                else
                    color = :green
                end
                string = el.to_s
                piece_color = el.color
                print " #{string} ".colorize(:color => piece_color, :background => color)
            end
            puts
        end
        nil
    end

    def do_loop
        while true
            system("clear")
            render
            pos = cursor.get_input
            if pos
                @possible_moves += board[pos].moves 
            else
                @possible_moves = []
            end
            system("clear")
            render
        end
    end

    private 
    attr_reader :cursor
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new
    display = Display.new(board)
    board[[3,3]] = Queen.new([3,3], board, :white)
    display.do_loop
end