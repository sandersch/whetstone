require 'word_tree'

describe WordTree do
  let(:tree) { described_class.new }

  context "when empty" do
    describe "#contains?" do
      subject { tree.contains? word }

      let(:word) { "apple" }

      it { should be_false }
    end
  end

  context "with nodes" do
    let(:dictionary) { ["read", "dear", "red", "apple", "reader"] }

    before do
      tree.store dictionary
    end

    describe "#contains?" do
      subject { tree.contains? word }

      context "a word in the tree" do
        let(:word) { "apple" }

        it { should be_true }
      end

      context "a word NOT in the tree" do
        let(:word) { "bogus" }

        it { should be_false }
      end
    end

  end
end
