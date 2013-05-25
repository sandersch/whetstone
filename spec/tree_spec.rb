require 'tree'

describe Tree::Node do
  subject { node }

  let(:node) { described_class.new(value) }
  let(:value) { mock :value }

  its(:value) { should == value }

  describe "adding a child" do
    subject { node.insert(child_node) }

    let(:child_node) { mock :child_node }

    its(:children) { should include child_node }
  end
end
