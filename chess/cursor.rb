require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

#constant hash establishes what the symbols mean in context of board.
MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
  end

  #we create a key variable to extract from the keymap
  #we use our handle_key method to decide what to do what to do with the key
  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  #stuff that we don't really need to know but gets a character from
  #the keyboard.

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  #handler tells board to do things based on what key was pressed.
  def handle_key(key)
    case key 
    when :space, :return
      @selected = !@selected
      return cursor_pos if @selected
    when :left
      update_pos(MOVES[:left])
      return nil
    when :right
      update_pos(MOVES[:right])
      return nil
    when :up
      update_pos(MOVES[:up])
      return nil
    when :down
      update_pos(MOVES[:down])
      return nil
    when :ctrl_c
      Process.exit(0)
    end
  end

  def update_pos(diff)
    @cursor_pos.each_index do |i|
      @cursor_pos[i] += diff[i]
      if @cursor_pos[i] < 0
        @cursor_pos[i] = 0
      elsif @cursor_pos[i] > 7
        @cursor_pos[i] = 7
      end
    end
  end
end