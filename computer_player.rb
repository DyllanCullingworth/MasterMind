require './game_logic.rb'

class Computer
  attr_accessor :score, :secretCode

  include GameLogic

  def initialize(valid_colors)
    @score = 0
    @valid_colors = valid_colors
    @secretCode = pickRandomColors(@valid_colors)
  end

  def pickRandomColors(valid_colors)
    random_colors = []

    4.times do
      random_colors << valid_colors.keys[rand(valid_colors.size)]
    end
    random_colors
  end
end