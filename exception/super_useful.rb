# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue ArgumentError
    nil
  end
end

# PHASE 3
class CoffeeError < StandardError
end

FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee" 
    raise CoffeeError.new("Hey, you fed me coffee, I want fruit.")
  else 
    raise StandardError.new("Feed me a fruit!")
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue CoffeeError => e
    puts(e)
    retry
  end
end  

class YearsError < StandardError; end
class ShortNameError < StandardError; end
class DoYouEvenHaveAFavoritePasstimeError < StandardError; end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    if name.length <= 0
      raise ShortNameError.new("Your names too short! We can't be best friends!")
    end
    @yrs_known = yrs_known
    if yrs_known < 5
      raise YearsError.new("Hey I haven't known you that long man!")
    end
    @fav_pastime = fav_pastime
    if fav_pastime.length <= 0
      raise DoYouEvenHaveAFavoritePasstimeError.new("No passtime")
    end
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


