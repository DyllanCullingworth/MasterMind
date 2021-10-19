require 'colorize'

module Display
  def display_board
    clear
   
    display_banner
    display_info
    display_available_colors
    @breaker.display_guesses_and_feedback

    # p @secretCode
  end

  def display_banner
    puts "=====================================================".colorize(background: :light_black)
    puts "====================  MASTERMIND ====================".colorize(background: :light_black)
    puts "=====================================================".colorize(background: :light_black)
    puts ""
  end
  
  def display_rules
    clear

    display_banner

    puts "Welcome to the game of mastermind, you will be given a" 
    puts "choice to be the code maker or the code breaker. The" 
    puts "Code maker will create a secret code from 6 available"
    puts "colours, the code will consist of 4 colours, duplicates" 
    puts "are allowed. Each player will have 12 turns to try crack"
    puts "the code, failing to do so will result in a loss."
    puts ""  
    puts "Can you trick the computer?"
    puts ""
  end

  def display_guesses_and_feedback
    for i in 0...@guesses.length do

      display_color_blocks(@guesses[i])

      print "  Clues: "

      @feedback[i].each do |feedback_item|
        print " #{feedback_item} "
      end
      puts ""
    end
  end

  def display_color_blocks(arr)
    arr.each do |item|
      print "  #{item}  ".colorize(background: @valid_colors[item.to_sym].to_sym)
    end
  end

  def display_info
    puts "Code Breaker: #{@breaker.class}"
    puts "Try: #{@breaker.tries} / #{@breaker.max_tries}"
    puts "Score: #{@breaker.class}: #{@breaker.score} | #{@maker.class}: #{@maker.score}"
    puts "*: Right Color, Right Place"
    puts "x: Right Color, Wrong Place" 
  end

  def display_available_colors
    print "Available Colors: "

    @valid_colors.each do |key, value|
      print "  #{key}  ".colorize(background: value.to_sym)
      print " "
    end

    puts ""
    puts ""
  end

  def clear
    print "\e[2J\e[H"
  end
end