require 'sort/quicksort'

shared_examples "a correct sorting algorithm" do
  context "when sorting 1000 random integers" do
    let(:input) { Array.new(1_000) { rand 1_000_000_000 } }

    it 'sorts correctly' do
      output.should == input.sort
    end
  end
end

describe Quicksort do
  let(:output) { described_class.sort input }

  it_behaves_like "a correct sorting algorithm"
end
