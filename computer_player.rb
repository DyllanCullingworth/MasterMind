class ComputerPlayer < Player
  attr_accessor :score, :secretCode

  def initialize(valid_colors)
    super
  end

  def setCode
    random_colors = []

    4.times do
      random_colors << @valid_colors.keys[rand(@valid_colors.size)].to_s
    end
    random_colors
  end

  def make_a_guess
    # guesses must be all caps and in array

    guess = ['R','R','R','R']
    @guesses << guess
    return guess
  end

  # def is_valid_guess?(guess)
  #   return false unless guess.count == 4

  #   guess.each do |guess_item|
  #     unless @valid_colors.keys.include? guess_item.to_sym
  #       return false
  #     end
  #   end
  #   true
  # end
end