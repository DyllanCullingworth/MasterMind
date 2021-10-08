# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer’s random code.


# Think about how you would set this problem up!


# Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!




class MasterMind
  attr_accessor :tries, :max_tries, :guesses, :feedback

  def initialize(player, computer, validColors)
    clear
    @player = player
    @computer = computer
    @validColors = validColors
    @guesses = []
    @feedback = []
    @tries = 0
    @max_tries = 12
  

    @secretCode = @computer.secretCode
    
    play
  end


  def play
    while @tries < @max_tries
      display_board
      guess = make_a_guess
      @guesses << guess
      feedback(guess)
    end
  end

  def display_board
    clear
    puts "================================================="
    puts "==================  MASTERMIND =================="
    puts "================================================="
    puts ""

    p @secretCode

    for i in 0...@guesses.length do
      puts "#{i+1}. #{@guesses[i]} " + " | " + "  #{@feedback[i]}"
    end
  end

  def feedback(guess)
    secretCode = @secretCode
    guess_feedback = Array.new(4)
    guess = guess

    for i in 0...4 do
      guess.each_with_index do |guess_item, guess_index|
  
        if guess_item == secretCode[i]
          if guess_index == i
            guess_feedback[i] = '*'
            # guess[guess_index] = ''
            break
          else
            guess_feedback[i] = 'x'
            # guess[guess_index] = ''
            break
          end
        else
          guess_feedback[i] = '-'
        end
      end
    end

    @feedback << guess_feedback
  end

  def make_a_guess
    puts "Choose 4 colours from the list, seperated by commas"
    loop do
      guess = gets.upcase.chomp.gsub(' ', '').split(',')

      if is_valid_guess? guess
        return guess
      else
        puts "That was an invalid entry, please try again."
      end
    end
  end

  def is_valid_guess?(guess)
    return false unless guess.count == 4

    guess.each do |guess_item|
      unless @validColors.include? guess_item
        return false
      end
    end
    return true
  end



end



class Player
  attr_accessor :score, :secretCode

  def initialize(validColors)
    @score = 0
    @validColors = validColors
    # @secretCode = getSecretCode
  end

  private

  # def getSecretCode
  #   secretCode = []
  #   print "Please select a color from the list"
  # end
end

class Computer
  attr_accessor :score, :secretCode

  def initialize(validColors)
    @score = 0
    @validColors = validColors
    @secretCode = pickRandomColors(@validColors)
  end

end

# Computer generates 4 random colours from a list


def pickRandomColors(validColors)
  randomColors = []
  4.times do
    randomColors << validColors.sample
  end
  randomColors
end

def clear
  print "\e[2J\e[H"
end

validColors = ['R', 'G', 'B', 'O', 'W', 'B']
player = Player.new(validColors)
computer = Computer.new(validColors)
game = MasterMind.new(player, computer, validColors)