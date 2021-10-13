module GameLogic
   def play
    choose_role

    @secretCode = @maker.setCode

    
    while @game_over == false
      @breaker.tries += 1
      @breaker.display_board
      guess = @breaker.make_a_guess
      get_feedback(guess)
      game_over?(guess)
    end
  end

  def choose_role
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
      puts "Congratulations, you have won!!"
      p @secretCode
      @breaker.score += 1
      game_over!
    end

    if @breaker.tries >= @breaker.max_tries
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

    @breaker.feedback << guess_feedback
    return guess_feedback
  end
end