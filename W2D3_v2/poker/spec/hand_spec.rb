require 'hand'
require 'card'

describe Hand do

  let(:a_s) { Card.new(1, :spades)}
  let(:a_h) { Card.new(1, :hearts)}
  let(:a_c) { Card.new(1, :clubs)}
  let(:a_d) { Card.new(1, :diamonds)}

  let(:k_s) { Card.new(13, :spades)}
  let(:k_h) { Card.new(13, :hearts)}
  let(:k_c) { Card.new(13, :clubs)}
  let(:k_d) { Card.new(13, :diamonds)}

  let(:q_s) { Card.new(12, :spades)}
  let(:q_h) { Card.new(12, :hearts)}
  let(:q_c) { Card.new(12, :clubs)}
  let(:q_d) { Card.new(12, :diamonds)}

  let(:j_s) { Card.new(11, :spades)}
  let(:j_h) { Card.new(11, :hearts)}
  let(:j_c) { Card.new(11, :clubs)}
  let(:j_d) { Card.new(11, :diamonds)}

  let(:ten_s) { Card.new(10, :spades)}
  let(:ten_h) { Card.new(10, :hearts)}
  let(:ten_c) { Card.new(10, :clubs)}
  let(:ten_d) { Card.new(10, :diamonds)}

  let(:nine_s) { Card.new(9, :spades)}

  let(:filler) { double("filler", :value => 0, :suit => :blank)}

  let(:straight_flush){ Hand.new( [ten_s, j_s, q_s, k_s, a_s] )}
  let(:four_of_a_kind){ Hand.new( [filler, a_d, a_h, a_c, a_s] )}
  let(:full_house){ Hand.new( [a_c, k_h, a_h, k_s, a_s] )}
  let(:flush){ Hand.new( [nine_s, j_s, q_s, k_s, a_s] )}
  let(:straight){ Hand.new( [ten_s, j_h, q_h, k_s, a_s] )}
  let(:three_of_a_kind){ Hand.new( [filler, filler, a_h, a_c, a_s] )}
  let(:two_pair){ Hand.new( [filler, k_h, a_h, k_s, a_s] )}
  let(:one_pair){ Hand.new( [filler, filler, filler, a_h, a_s] )}
  let(:high_card){ Hand.new( [filler, filler, filler, filler, a_s] )}

  subject(:avg_hand){ Hand.new([a_c, q_s, ten_c, nine_s, k_d])}

  describe "#initialize" do
    it "takes and exposes a cards array" do
      expect(subject.cards).to eq([a_c, q_s, ten_c, nine_s, k_d])
    end
  end

  describe "#best_hand" do
    it "returns an array of cards"

    it "returns at least one card"

    it "returns only the cards that make up the most valuable hand"
  end

  describe "#beats_hand" do

    it "raises an error if passed something other than an array of cards"

    it "checks if self is more valuable than the best hand in other cards"

  end


end
