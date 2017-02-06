class Card
  attr_reader :value, :suit
  def initialize(value, suit)
    @value, @suit = value, suit
  end
end
