require './mastermind'
require 'colorize'

valid_colors = {
  'R': 'red',
  'G': 'green', 
  'C': 'cyan', 
  'M': 'magenta', 
  'Y': 'yellow', 
  'B': 'black'
}
player = Player.new(valid_colors)
computer = Computer.new(valid_colors)

MasterMind.new(player, computer, valid_colors)