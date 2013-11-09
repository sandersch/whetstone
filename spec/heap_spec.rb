require 'heap'

describe Heap, 'a minimum heap' do
  subject { heap }

  let(:heap) { Heap.new }

  context "with no elements" do
    describe '#size' do
      subject { super().size }
      it { should == 0 }
    end
  end

  context "with one element" do
    before do
      heap.insert(element)
    end

    let(:element) { 1 }

    describe '#size' do
      subject { super().size }
      it { should == 1 }
    end

    describe '#extract_min' do
      subject { super().extract_min }
      it { should be element }
    end

    describe "testing that the heap property holds" do
      subject { heap.satisfies_heap_property_at? index }
      let(:index) { 0 }

      it { should be_truthy }
    end
  end

  describe "with many elements" do
    before do
      elements.each do |elem|
        heap.insert elem
      end
    end

    let(:elements) { [5, 2, 3, 1, 4].shuffle }

    describe '#size' do
      subject { super().size }
      it { should == 5 }
    end

    describe '#extract_min' do
      subject { super().extract_min }
      it { should == 1 }
    end
  end

  describe "testing that the heap property holds" do
    subject { heap.satisfies_heap_property_at? index }

    context "at a leaf node" do
      let(:index) { 0 }

      it { should be_truthy }
    end

    context "at a node with one child" do
      let(:index) { 1 }

      context "that is greater than the node" do
        before do
          heap.instance_eval { @nodes = [0, 1, 2, 3] }
        end

        it { should be_truthy }
      end

      context "that is less than the node" do
        before do
          heap.instance_eval { @nodes = [0, 3, 2, 1] }
        end

        it { should be_falsey }
      end
    end

    context "at a node with two children" do
      context "when a child is less than the node"

      context "when both children are greater than the node"
    end
  end
end

describe Heap, "class methods" do
  describe "determining the parent of" do
    subject { described_class.parent_of(index) }
    let(:k) { rand(1..100) }

    context "index 0" do
      let(:index) { 0 }

      it { should be_nil }
    end

    context "an odd index" do
      let(:index) { 2*k + 1 }

      it { should == k }
    end

    context "an even index" do
      let(:index) { 2*k + 2 }

      it { should == k }
    end
  end

  describe "determining the children of an element" do
    let(:subject) { described_class.children_of(index) }

    context "at index 0" do
      let(:index) { 0 }

      it { should == [1, 2] }
    end

    context "at a random index" do
      let(:k) { rand(0..100) }
      let(:index) { k }

      it { should == [2 * k + 1, 2 * k + 2] }
    end
  end
end
