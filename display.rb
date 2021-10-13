require 'colorize'

module Display
  def display_board
    clear
   
    display_banner
    display_info
    display_available_colors
    display_guesses_and_feedback
  end

  def display_banner
    puts "=====================================================".colorize(background: :light_black)
    puts "====================  MASTERMIND ====================".colorize(background: :light_black)
    puts "=====================================================".colorize(background: :light_black)
    puts ""
  end

  def display_guesses_and_feedback
    for i in 0...@guesses.length do

      @guesses[i].each do |guess_item|
        print "  #{guess_item}  ".colorize(background: @valid_colors[guess_item.to_sym].to_sym)
      end

      print "  Clues: "

      @feedback[i].each do |feedback_item|
        print " #{feedback_item} "
      end
      puts ""
    end
  end

  def display_info
    puts "Try: #{@tries} / #{@max_tries}"
    puts "Score: #{@score}"
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