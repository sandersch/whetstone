require 'heap'

describe Heap, 'a minimum heap' do
  subject { heap }

  let(:heap) { Heap.new }

  context "with no elements" do
    its(:size) { should == 0 }
  end

  context "with one element" do
    before do
      heap.insert(element)
    end

    let(:element) { mock :element }

    its(:size) { should == 1 }
    its(:extract_min) { should be element }
  end
end
