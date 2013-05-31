require 'tree'

describe Tree do
  describe "adding values to the tree" do
    before do
     subject.store value
    end

    let(:value) { mock }

    it 'contains the stored value' do
      subject.contains?(value).should be_true
    end
  end
end
