require './human_player.rb'
require './computer_player.rb'
require './game_logic.rb'


class MasterMind
  attr_accessor :tries, :max_tries, :guesses, :feedback

  include GameLogic

  def initialize(player, computer, valid_colors)
    clear
    @player = player
    @computer = computer
    @valid_colors = valid_colors
    @guesses = []
    @feedback = []
    @tries = 0
    @max_tries = 12
    @game_over = false
    @secretCode = @computer.secretCode
    
    play
  end

  def play
    while @game_over == false
      @tries += 1
      display_board
      guess = make_a_guess
      feedback = get_feedback(guess)
      game_over?(feedback)
    end
    puts "Thank you for playing!"
  end

  def display_board
    clear
    puts "================================================="
    puts "==================  MASTERMIND =================="
    puts "================================================="
    puts ""

    puts "Color List: #{@valid_colors}"
    puts "#{@tries} / #{@max_tries}"
    puts "Score: #{@player.score}"

    # p @secretCode

    puts "{============[\"X\",\"X\",\"X\",\"X\"]============}"

    for i in 0...@guesses.length do
      puts "#{i+1}. #{@guesses[i]} " + " | " + "  #{@feedback[i]}"
    end
  end

  def game_over?(feedback)
    if feedback.count('*') == 4
      puts "Congratulations, you have won!!"
      p @secretCode
      @player.score += 1
      game_over!
    end

    if @tries >= @max_tries
      puts "Out of tries, you lose!"
      game_over!
    end
  end

  def game_over!
    @game_over = true
    puts "Would you like to play again? [Y/N]"
    if gets.chomp.upcase == 'Y'
      game = MasterMind.new(@player, @computer, @valid_colors)
    else
      puts "Thank you for playing!"
    end
  end

  def get_feedback(guess)
    guess_feedback = []
    available_values = Hash.new 0
    used_values = Hash.new 0
    
    @secretCode.each { |value| available_values[value] += 1 }
    
    guess.each_with_index do |guess_item, index|
      if guess_item == @secretCode[index]
        guess_feedback << '*'
        used_values[guess_item] += 1
      end
    end

    guess.each_with_index do |guess_item, index|
      if (guess_item != @secretCode[index])
        if (@secretCode.include? guess_item) && (available_values[guess_item] > used_values[guess_item])
          guess_feedback << 'x'
          used_values[guess_item] += 1
        else
          guess_feedback << '-' 
        end
      end
    end

    @feedback << guess_feedback
    return guess_feedback
  end

  def make_a_guess
    puts "Choose 4 colours from the list, seperated by commas"
    loop do
      guess = gets.upcase.chomp.gsub(' ', '').split(',')

      if is_valid_guess? guess
        @guesses << guess
        return guess
      else
        puts "That was an invalid entry, please try again."
      end
    end
  end

  def is_valid_guess?(guess)
    return false unless guess.count == 4

    guess.each do |guess_item|
      unless @valid_colors.include? guess_item
        return false
      end
    end
    return true
  end
end





def clear
  print "\e[2J\e[H"
end

validColors = ['R', 'G', 'P', 'O', 'W', 'B']
player = Player.new(validColors)
computer = Computer.new(validColors)
game = MasterMind.new(player, computer, validColors)