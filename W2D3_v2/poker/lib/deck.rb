require_relative 'card.rb'

class Deck
  attr_reader :contents

  SUITS = [:spades, :hearts, :clubs, :diamonds]

  def initialize
    @contents = []
    populate
  end

  def shuffle
    @contents.shuffle!
  end

  def draw(amount = nil)
    raise "Not enough cards" if amount && amount > @contents.size

    return @contents.shift if amount.nil?

    amount.times.with_object([]) do |i, result|
      result << contents.shift
    end

  end

  private

  def populate
    SUITS.each do |suit|
      (1..13).each do |value|
        @contents << Card.new(value, suit)
      end
    end
  end

end
