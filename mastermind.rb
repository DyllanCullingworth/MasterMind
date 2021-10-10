require './human_player.rb'
require './computer_player.rb'
require './game_logic.rb'
require './display.rb'

class MasterMind
  attr_accessor :tries, :max_tries, :guesses, :feedback

  include GameLogic
  include Display

  def initialize(player, computer, valid_colors)
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
end