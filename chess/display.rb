require "colorize"
require "cursor.rb"

class Display   
    def initialize(board)
        @cursor = Cursor.new([0,0], board)
    end
    def print_grid
        puts(" " + %w(0 1 2 3 4 5 6 7).join(" "))
        @grid.each_with_index do |row, i|
            print("#{i} ")
            row.each do |el|
                print el ? el.single_letter : " "
                print " "
            end
            puts
        end
        nil
    end

end