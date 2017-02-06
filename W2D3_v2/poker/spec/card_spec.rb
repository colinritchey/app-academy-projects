require 'card'

describe Card do
  subject(:ace_of_hearts) { Card.new(13, :heart)}
  describe "#initialize" do
    it "initializes with a value" do
      expect(ace_of_hearts.value).to eq(13)
    end
    it "initializes with a suit" do
      expect(ace_of_hearts.suit).to eq(:heart)
    end
  end

end
