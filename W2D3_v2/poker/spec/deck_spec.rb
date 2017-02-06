require 'deck'

describe Deck do
  subject { Deck.new }

  describe "#initialize" do
    it "exposes a contents array" do
      expect(subject.contents).to be_a(Array)
    end

    it "creates 52 cards" do
      expect(subject.contents.size).to eq(52)
    end

    it "has only cards as contents" do
      expect(subject.contents).to all( be_a(Card) )
    end
  end

  describe "#shuffle" do
    it "shuffles the cards" do
      copy = subject.contents.dup
      subject.shuffle
      expect(subject.contents).to_not eq(copy)
    end

    it "doesn't change the cards themselves" do
      copy = subject.contents.dup
      subject.shuffle
      sorted = subject.contents.sort_by{ |card| [card.value, card.suit] }
      expect(sorted).to eq(copy.sort_by{ |card| [card.value, card.suit] })
    end

  end

  describe "#draw" do

    it "raises an error if too many cards are requested" do
      expect { subject.draw(53) }.to raise_error("Not enough cards")
    end

    it "decreases the size of the deck when a card is removed" do
      subject.draw
      expect(subject.contents.size).to eq(51)
    end

    context "when not given an argument" do
      it "returns a Card from the top of the deck" do
        top_card = subject.contents.first
        expect(subject.draw).to eq(top_card)
      end

    end

    context "when given a number as an argument" do
      it "returns an array of cards" do
        expect(subject.draw(2)).to be_a(Array)
      end

      it "returns a number of cards equal to argument" do
        expect(subject.draw(2).size).to eq(2)
      end
    end
  end
end
