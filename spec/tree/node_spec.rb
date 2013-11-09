require 'tree/node'

class Tree
  describe Node do
    subject { parent_node }

    let(:parent_node) { described_class.new(parent_value) }
    let(:parent_value) { rand(2**16) }

    describe '#value' do
      subject { super().value }
      it { should == parent_value }
    end

    describe "comparing two nodes" do
      subject { parent_node <=> other_node }

      let(:other_node) { described_class.new(other_value) }

      context "when the other node's value is lesser" do
        let(:other_value) { parent_value - 1 }

        it { should == 1 }
      end

      context "when the other node's value is equal" do
        let(:other_value) { parent_value  }

        it { should == 0 }
      end

      context "when the other node's value is greater" do
        let(:other_value) { parent_value + 1 }

        it { should == -1 }
      end
    end

    context "with no children" do
      describe "checking if the node contains" do
        subject { parent_node.contains? value }

        context 'its value' do
          let(:value) { parent_value }

          it { should be_truthy }
        end

        context 'another value' do
          let(:value) { parent_value + 100 }

          it { should be_falsey }
        end
      end

      describe "adding a child" do
        subject { parent_node.insert(new_child_node) }

        let(:new_child_node) { described_class.new(new_child_value) }

        subject { parent_node.insert(new_child_node) }

        let(:new_child_node) { described_class.new(new_child_value) }

        context 'when the new child is less than the parent' do
          let(:new_child_value) { parent_value - 1 }

          describe '#left' do
            subject { super().left }
            it { should be new_child_node }
          end
        end

        context 'when the new child is equal to the parent' do
          let(:new_child_value) { parent_value }

          describe '#left' do
            subject { super().left }
            it { should be new_child_node }
          end
        end

        context 'when the new child is greater than the parent' do
          let(:new_child_value) { parent_value + 1 }

          describe '#right' do
            subject { super().right }
            it { should be new_child_node }
          end
        end
      end
    end

    context "with one child" do
      let(:existing_child_node) { described_class.new existing_child_value }

      before do
        parent_node.insert existing_child_node
      end

      context "on its left" do
        let(:existing_child_value) { parent_value - 1 }

        describe "checking if the node contains" do
          subject { parent_node.contains? value }

          context 'its value' do
            let(:value) { parent_value }

            it { should be_truthy }
          end

          context 'a value less than itself' do
            let(:value) { parent_value - 100 }

            it 'asks the existing left child if it contains the value' do
              expect(existing_child_node).to receive(:contains?).with(value)

              subject
            end
          end

          context 'a value greater than itself' do
            let(:value) { parent_value + 100 }

            it { should be_falsey }
          end
        end

        describe "adding a child" do
          subject { parent_node.insert(new_child_node) }

          let(:new_child_node) { described_class.new(new_child_value) }

          context 'when the new child is less than the parent' do
            let(:new_child_value) { parent_value - 1 }

            it 'tells the existing left child node to insert the new child node' do
              expect(existing_child_node).to receive(:insert).with(new_child_node)

              subject
            end
          end

          context 'when the new child is greater than the parent' do
            let(:new_child_value) { parent_value + 1 }

            describe '#right' do
              subject { super().right }
              it { should be new_child_node }
            end
          end
        end
      end

      context "on its right" do
        let(:existing_child_value) { parent_value + 1 }

        describe "checking if the node contains" do
          subject { parent_node.contains? value }

          context 'its value' do
            let(:value) { parent_value }

            it { should be_truthy }
          end

          context 'a value less than itself' do
            let(:value) { parent_value - 100 }

            it { should be_falsey }
          end

          context 'a value greater than itself' do
            let(:value) { parent_value + 100 }

            it 'asks the existing right child if it contains the value' do
              expect(existing_child_node).to receive(:contains?).with(value)

              subject
            end
          end
        end

        describe "adding a child" do
          subject { parent_node.insert(new_child_node) }

          let(:new_child_node) { described_class.new(new_child_value) }

          context 'that is less than the parent' do
            let(:parent_value) { 5 }
            let(:new_child_value) { parent_value - 1 }

            describe '#left' do
              subject { super().left }
              it { should be new_child_node }
            end
          end

          context 'that is greater than the parent' do
            let(:parent_value) { 5 }
            let(:new_child_value) { parent_value + 1 }

            it 'tells the existing right child node to insert the new child node' do
              expect(existing_child_node).to receive(:insert).with(new_child_node)

              subject
            end
          end
        end
      end
    end

    context "with two children" do
      let(:existing_left_child) { described_class.new(parent_value - 1) }
      let(:existing_right_child) { described_class.new(parent_value + 1) }

      before do
        parent_node.insert existing_left_child
        parent_node.insert existing_right_child
      end

      describe "checking if the node contains" do
        subject { parent_node.contains? value }

        context 'its value' do
          let(:value) { parent_value }

          it { should be_truthy }
        end

        context 'a value less than itself' do
          let(:value) { parent_value - 100 }

          it 'asks the existing left child if it contains the value' do
            expect(existing_left_child).to receive(:contains?).with(value)

            subject
          end
        end

        context 'a value greater than itself' do
          let(:value) { parent_value + 100 }

          it 'asks the existing right child if it contains the value' do
            expect(existing_right_child).to receive(:contains?).with(value)

            subject
          end
        end
      end

      describe "adding a child" do
        subject { parent_node.insert(new_child_node) }

        let(:new_child_node) { described_class.new(new_child_value) }

        context 'when the new child is less than the parent' do
          let(:new_child_value) { parent_value - 1 }

          it 'tells the existing left child node to insert the new child node' do
            expect(existing_left_child).to receive(:insert).with(new_child_node)

            subject
          end
        end

        context 'when the new child is greater than the parent' do
          let(:new_child_value) { parent_value + 1 }

          it 'tells the existing right child node to insert the new child node' do
            expect(existing_right_child).to receive(:insert).with(new_child_node)

            subject
          end
        end
      end
    end
  end
end
