require 'tree'

describe Tree::Node do
  subject { parent_node }

  let(:parent_node) { described_class.new(parent_value) }
  let(:parent_value) { rand(2**16) }

  its(:value) { should == parent_value }

  describe "adding a child" do
    subject { parent_node.insert(new_child_node) }

    let(:new_child_node) { described_class.new(new_child_value) }
    let(:new_child_value) { parent_value }

    its(:children) { should include new_child_node }

    context 'to a node with no children' do
      context 'when the child is less than the parent' do
        let(:new_child_value) { parent_value - 1 }

        its(:left) { should be new_child_node }
      end

      context 'when the child is equal to the parent' do
        let(:new_child_value) { parent_value }

        its(:left) { should be new_child_node }
      end

      context 'when the child is greater than the parent' do
        let(:new_child_value) { parent_value + 1 }

        its(:right) { should be new_child_node }
      end
    end

    context 'to a node with one existing child' do
      let(:existing_child_node) { described_class.new existing_child_value }

      before do
        parent_node.insert existing_child_node
      end

      context 'on its left' do
        let(:existing_child_value) { parent_value - 1 }

        context 'when the child is less than the parent' do
          let(:new_child_value) { parent_value - 1 }

          it 'tells the left child value to insert the value' do
            existing_child_node.should_receive(:insert).with(new_child_node)

            subject
          end
        end

        context 'when the child is greater than the parent' do
          let(:new_child_value) { parent_value + 1 }

          its(:right) { should be new_child_node }
        end
      end

      context 'on its right' do
        let(:existing_child_value) { parent_value + 1 }

        context 'when the child is less than the parent' do
          let(:parent_value) { 5 }
          let(:new_child_value) { parent_value - 1 }

          its(:left) { should be new_child_node }
        end

        context 'when the child is greater than the parent' do
          let(:parent_value) { 5 }
          let(:new_child_value) { parent_value + 1 }

          it 'tells the right child value to insert the value' do
            existing_child_node.should_receive(:insert).with(new_child_node)

            subject
          end
        end
      end
    end

    context 'to a node with two children' do
      let(:existing_left_child) { described_class.new(parent_value - 1) }
      let(:existing_right_child) { described_class.new(parent_value + 1) }

      before do
        parent_node.insert existing_left_child
        parent_node.insert existing_right_child
      end

      context 'when the child is less than the parent' do
        let(:new_child_value) { parent_value - 1 }

        it 'tells the left child value to insert the value' do
          existing_left_child.should_receive(:insert).with(new_child_node)

          subject
        end
      end

      context 'when the child is greater than the parent' do
        let(:new_child_value) { parent_value + 1 }

        it 'tells the left child value to insert the value' do
          existing_right_child.should_receive(:insert).with(new_child_node)

          subject
        end
      end
    end
  end
end
