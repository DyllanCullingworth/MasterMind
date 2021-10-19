# require './human_player.rb'
# require './computer_player.rb'
require './game_logic.rb'
require './display.rb'

class MasterMind
  attr_accessor :maker, :breaker

  include GameLogic
  include Display

  def initialize(player, computer, valid_colors)
    @player = player
    @computer = computer
    @valid_colors = valid_colors
    @winner = nil   
    @game_over = false
    
    play
  end
end