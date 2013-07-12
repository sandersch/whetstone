require 'sort/quicksort'

describe Quicksort do
  subject { described_class.sort input.clone }

  let(:input) { Array.new(1_000) { rand 1_000_000_000 } }

  it 'sorts correctly' do
    should == input.sort
  end
end
