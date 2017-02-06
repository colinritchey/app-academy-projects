require 'tdd'

describe Array do
  describe "#my_uniq" do
    let(:unique_array){ [1, 2, 3, 4] }
    let(:array_with_dups) { [1, 1, 2, 2, 3, 4, 4] }

    it "returns an empty array if self is empty" do
      expect([].my_uniq).to eq([])
    end

    it "returns identical array if there are no duplicate elements" do
      expect(unique_array.my_uniq).to eq(unique_array)
    end

    it "doesn't modify self" do
      expect(unique_array.my_uniq).to_not be(unique_array)
    end

    it "returns unique elements in the order they appeared" do
      expect(array_with_dups.my_uniq).to eq(unique_array)
    end

  end

  describe "#two_sum" do

    let(:no_pair){ [1, 2] }
    let(:two_pair){ [-1, 0, 2, -2, 1] }

    it "returns empty array if self is empty" do
      expect([].two_sum).to eq([])
    end

    it "returns empty if there is no pair" do
      expect(no_pair.two_sum).to eq([])
    end

    it "returns the indices of pairs in order" do
      expect(two_pair.two_sum).to eq([[0, 4], [2, 3]])
    end

  end

  describe "#my_transpose" do

    let(:rows) do [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]
    end

    let(:columns) do [
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
      ]
    end

    it "returns empty array if self contains only empty arrays" do
      expect([[]].my_transpose).to eq([])
    end

    it "returns same array if grid is 1x1" do
      expect([[0]].my_transpose).to eq([[0]])
    end

    it "returns the transpose of rows" do
      expect(rows.my_transpose).to eq(columns)
    end

    it "returns the transpose of columns" do
      expect(columns.my_transpose).to eq(rows)
    end

  end

end

describe "#stock_picker" do

  let(:one_day){ [10] }
  let(:only_losses){ [10, 5, 2] }
  subject { [5, 3, 1, 2, 10, 2, 1] }

  context "when not passed an array" do
    it "raises ArgumentError" do
      expect { stock_picker('banana') }.to raise_error(ArgumentError)
    end
  end

  context "when passed an array containing things other than numbers" do
    it "raises ArgumentError" do
      expect { stock_picker(['banana']) }.to raise_error(ArgumentError)
    end
  end

  it "returns an empty array if fewer than two days are given" do
    expect(stock_picker(one_day)).to eq([])
  end

  it "returns the indices of the best day to buy and then sell stock" do
    expect(stock_picker(subject)).to eq([2, 4])
  end

  it "returns an empty array if there is no profit to be made" do
    expect(stock_picker(only_losses)).to eq([])
  end

end
