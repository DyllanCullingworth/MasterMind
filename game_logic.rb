module GameLogic
   def play
    while @game_over == false
      @tries += 1
      display_board
      guess = make_a_guess
      get_feedback(guess)
      game_over?(guess)
    end
  end

   def game_over?(guess)
    if @secretCode == guess
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
        # else
        #   guess_feedback << '-' 
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
      unless @valid_colors.keys.include? guess_item.to_sym
        return false
      end
    end
    true
  end
end