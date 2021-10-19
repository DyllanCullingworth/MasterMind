module GameLogic
   def play
    choose_role

    @secretCode = @maker.setCode

    while @game_over == false
      @breaker.tries += 1
      display_board
      guess = @breaker.make_a_guess
      guess_feedback = get_feedback(guess, @secretCode)
      @breaker.feedback << guess_feedback
      game_over?(guess)
    end
  end

  def choose_role
    display_rules

    puts "Would you like to be the Code Breaker or the Code Maker?"
    puts "Select 1 for Breaker and 2 for Maker"
    answer = gets.chomp
    if answer == '1'
      self.maker = @computer
      self.breaker = @player
    elsif answer == '2'
      self.maker = @player
      self.breaker = @computer
    end
  end

  def game_over?(guess)
    if @secretCode == guess
      @winner = @breaker
      game_over!
    end

    if @breaker.tries >= @breaker.max_tries
      @winner = @maker
      game_over!
    end
  end

  def game_over!
    @game_over = true
    @winner.score += 1
    display_board

    reset_player

    if @winner.class == ComputerPlayer
      puts ""
      puts "Sorry, you lose this time!"
      puts ""
    else
      puts ""
      puts "You are the Winner!"
      puts ""
    end

    display_color_blocks(@secretCode)
    puts ""

    play_again?
  end

  def reset_player
    @breaker.tries = 0
    @breaker.guesses = []
    @breaker.feedback = []
    if @breaker.class == ComputerPlayer
      @breaker.possible_combinations = nil
    end
  end

  def play_again?
    puts "Would you like to play again? [Y/N]"
    if gets.chomp.upcase == 'Y'
      clear
      MasterMind.new(@player, @computer, @valid_colors)
    else
      puts "Thank you for playing!"
    end
  end

  def get_feedback(guess, secretCode)
    guess_feedback = []
    available_values = Hash.new 0
    used_values = Hash.new 0
    
    secretCode.each { |value| available_values[value] += 1 }
    
    guess.each_with_index do |guess_item, index|
      if guess_item == secretCode[index]
        guess_feedback << '*'
        used_values[guess_item] += 1
      end
    end

    guess.each_with_index do |guess_item, index|
      if (guess_item != secretCode[index])
        if (secretCode.include? guess_item) && (available_values[guess_item] > used_values[guess_item])
          guess_feedback << 'x'
          used_values[guess_item] += 1
        end
      end
    end

    return guess_feedback
  end
end