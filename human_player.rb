class Player
  attr_accessor :score, :secretCode

  def initialize(valid_colors)
    @score = 0
    @valid_colors = valid_colors
    # @secretCode = getSecretCode
  end

  private

  # def getSecretCode
  #   secretCode = []
  #   print "Please select a color from the list"
  # end
end