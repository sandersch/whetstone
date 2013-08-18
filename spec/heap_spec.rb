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

  pending "with many elements" do
    before do
      elements.each do |elem|
        heap.insert elem
      end
    end

    let(:elements) { [5, 2, 3, 1, 4] }

    its(:size) { should == 5 }
    its(:extract_min) { should == 1 }
  end
end

describe Heap, "class methods" do
  let(:k) { rand(1000) }

  describe "determining the parent of" do
    let(:subject) { described_class.parent_of(index) }

    context "an even index" do
      let(:index) { 2 * k }

      it { should == k }
    end

    context "an odd index" do
      let(:index) { 2 * k + 1}

      it { should == k }
    end
  end

  describe "determining the children of an element" do
    let(:subject) { described_class.children_of(k) }

    it { should == [2 * k, 2 * k + 1] }
  end
end
