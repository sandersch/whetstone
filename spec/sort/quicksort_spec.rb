require 'sort/quicksort'

shared_examples "a correct sorting algorithm" do
  context "when sorting 1000 random integers" do
    let(:input) { Array.new(1_000) { rand 1_000_000_000 } }

    it 'sorts correctly' do
      expect(output).to eq(input.sort)
    end
  end
end

describe Quicksort do
  let(:output) { described_class.sort input }

  it_behaves_like "a correct sorting algorithm"

  describe "in place" do
    before { subject }

    describe "partitioning" do
      subject { described_class.partition(array, left, right, pivot_index) }

      let(:array) { [6, 2, 8, 3, 5] }
      let(:left) { 0 }
      let(:right) { 4 }
      let(:pivot_index) { 3 }

      it 'partitions correctly' do
        expect(array).to eq([2, 3, 8, 6, 5])
      end

      it 'returns the resulting partition index' do
        should == 2
      end
    end

    describe "sorting" do
      subject { described_class.sort! input }

      it_behaves_like "a correct sorting algorithm"
    end
  end
end
