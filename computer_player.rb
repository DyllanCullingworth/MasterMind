require './game_logic.rb'

class Computer
  attr_accessor :score, :secretCode

  include GameLogic

  def initialize(valid_colors)
    @score = 0
    @valid_colors = valid_colors
    @secretCode = pickRandomColors(@valid_colors)
  end

  def pickRandomColors(validColors)
    randomColors = []
    4.times do
      randomColors << validColors.sample
    end
    randomColors
  end
end