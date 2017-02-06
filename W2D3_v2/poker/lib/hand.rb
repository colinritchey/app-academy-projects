class Hand
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def best_hand

    if (result = Hand::four_of_a_kind(@cards))
      return result
    end
    nil

  end

  private

  def self.straight_flush(cards)
  end

  def self.four_of_a_kind(cards)
    four = cards.select do |card|
      cards.count{ |sub_card| sub_card.value == card.value } == 4
    end
    four.empty? ? nil : four
  end

  def self.three_of_a_kind(cards)
    three = cards.select do |card|
      cards.count{ |sub_card| sub_card.value == card.value } == 3
    end
    three.empty? ? nil : three
  end

end
