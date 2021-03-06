class ComputerPlayer < Player
  attr_accessor :score, :secretCode, :possible_combinations

  def initialize(valid_colors)
    super
  end

  def setCode
    random_colors
  end

  def make_a_guess
    @possible_combinations ||= all_possible_combinations

    remove_impossible_combinations

    guess = @possible_combinations[rand(@possible_combinations.size)]
    
    sleep(0.5)
    @possible_combinations - guess
    @guesses << guess
    return guess
  end

  def random_colors
    colors = []

    4.times do
      colors << @valid_colors.keys[rand(@valid_colors.size)].to_s
    end
    colors
  end

  private

  def remove_impossible_combinations
    unless @feedback.empty?
      # remove all combinations containing the colors in the guess if feedback is empty
      if @feedback.last.length == 0
        @guesses.last.each do |guess|
          @possible_combinations.delete_if { |combo| combo.include? guess }
        end
      end

      # remove all combinations not containing the colors in the guess if feedback is full
      if @feedback.last.length == 4
        @guesses.last.each do |guess|
          @possible_combinations.delete_if { |combo| !combo.include? guess }
        end
      end
      
      # remove all combinations that do not provide the same feedback if the last guess was the secretCode
      @possible_combinations.each do |guess|
        unless get_feedback(guess, @guesses.last) == @feedback.last
          @possible_combinations.delete(guess)
        end
      end
    end
  end

  def all_possible_combinations
    arr = @valid_colors.keys.map { |key| key.to_s }
    arr *= 4
    arr.permutation(4).to_a.uniq
  end
end