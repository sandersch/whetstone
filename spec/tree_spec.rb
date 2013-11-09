require 'tree'

describe Tree do
  describe "adding values to the tree" do
    before do
     subject.store value
    end

    let(:value) { double }

    it 'contains the stored value' do
      expect(subject.contains?(value)).to be_truthy
    end
  end
end
