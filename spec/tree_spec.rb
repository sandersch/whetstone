require 'tree'

describe Tree::Node do
  subject { node }

  let(:node) { described_class.new(value) }
  let(:value) { mock :value }

  its(:value) { should == value }

  describe "adding a child" do
    subject { node.insert(child_node) }

    let(:child_node) { described_class.new(child_value) }
    let(:child_value) { mock }

    its(:children) { should include child_node }

    context 'that is smaller than the parent node' do
      let(:value) { 5 }
      let(:child_value) { value - 1 }

      its(:left) { should be child_node }
    end

    context 'that is equal to the parent node' do
      let(:value) { 5 }
      let(:child_value) { value }

      its(:left) { should be child_node }
    end
  end
end
