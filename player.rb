require './game_logic'
require './display'

class Player
  attr_accessor :score, :secretCode, :guesses, :feedback, :tries, :max_tries

  include GameLogic
  include Display

  def initialize(valid_colors)
    @score = 0
    @valid_colors = valid_colors
    @tries = 0
    @max_tries = 12
    @guesses = []
    @feedback = []
  end

  def setCode
    # Set in child class
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
      unless @valid_colors.keys.include? guess_item.to_sym
        return false
      end
    end
    true
  end
end