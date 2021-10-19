class HumanPlayer < Player
  attr_accessor :score, :secretCode

  def initialize(valid_colors)
    super
  end

  def setCode
    clear
    display_available_colors

    puts "Create a secret code from the colors in the list, seperated by commas"
    loop do
      code = gets.upcase.chomp.gsub(' ', '').split(',')

      if is_valid? code
        return code
      else
        puts "That was an invalid entry, please try again."
      end
    end
  end

  def make_a_guess
    puts "Choose 4 colours from the list, seperated by commas"
    loop do
      guess = gets.upcase.chomp.gsub(' ', '').split(',')

      if is_valid? guess
        @guesses << guess
        return guess
      else
        puts "That was an invalid entry, please try again."
      end
    end
  end

  def is_valid?(color_array)
    return false unless color_array.count == 4

   color_array.each do |array_item|
      unless @valid_colors.keys.include? array_item.to_sym
        return false
      end
    end
    true
  end
end