require './mastermind'
require './player'
require './human_player'
require './computer_player'
require 'colorize'

valid_colors = {
  'R': 'red',
  'G': 'green', 
  'C': 'cyan', 
  'P': 'magenta', 
  'Y': 'yellow', 
  'B': 'black'
}

player = HumanPlayer.new(valid_colors)
computer = ComputerPlayer.new(valid_colors)
game = MasterMind.new(player, computer, valid_colors)