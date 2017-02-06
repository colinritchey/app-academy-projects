require 'towers_of_hanoi'

describe TowersOfHanoi do

  subject { TowersOfHanoi.new }

  describe "#initialize" do
    let(:custom_array_game) { TowersOfHanoi.new([[1], []]) }

    it "initializes with a passed-in array" do
      expect(custom_array_game.towers).to eq([[1], []])
    end

    it "initializes with the default array if no parameters" do
      expect(subject.towers).to eq([[3, 2, 1], [], []])
    end

    it "exposes a towers variable" do
      expect(subject).to respond_to(:towers)
    end
  end

  describe "#won?" do

    let(:easy_game) { TowersOfHanoi.new([[1], [], []]) }

    it "returns true if the entire tower has been moved" do
      shifted_item = easy_game.towers[0].shift
      easy_game.towers[1] << shifted_item
      expect(easy_game.won?).to be true
    end

    it "returns false if more than one tower has items" do
      easy_game.towers[1] << easy_game.towers[0].pop
      easy_game.towers[2] << 2
      expect(easy_game.won?).to be false
    end

    it "returns false if the starting array has all items" do
      expect(easy_game.won?).to be false
    end
  end

  describe "#move" do
    let(:default_towers){ [[3, 2, 1], [], []] }
    it "raises an error if starting array is empty" do
      expect { subject.move(1, 2) }.to raise_error("Empty starting position")
    end

    it "raises an error if given an invalid tower index" do
      expect { subject.move(0, 99) }.to raise_error("Tower does not exist")
    end

    it "refuses to move an item on top of a smaller item" do
      subject.towers[1] << 100
      subject.move(1, 0)
      expect(subject.towers).to eq([[3, 2, 1], [100], []])
    end

    it "moves the last item from the first tower onto the other tower" do
      subject.move(0, 1)
      expect(subject.towers).to eq([[3, 2], [1], []])
    end
  end

end
