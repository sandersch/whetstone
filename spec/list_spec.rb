require 'list'

describe List do
  subject { list }

  let(:list) { described_class.new }

  context "with no entries" do
    its(:size) { should == 0 }

    describe "adding an entry" do
      subject { list.add new_value }

      let(:new_value) { double }

      its(:size) { should == 1 }
    end

    describe "checking if the list contains a value" do
      subject { list.contains? other_value }

      let(:other_value) { double }

      it { should be_false }
    end
  end

  context "with one entry" do
    let(:list) { described_class.new existing_value }
    let(:existing_value) { double }

    its(:size) { should == 1 }

    describe "adding an entry" do
      subject { list.add new_value }

      let(:new_value) { double }

      its(:size) { should == 2 }
    end

    describe "checking if the list contains a value" do
      subject { list.contains? other_value }

      context "when the value is stored in the list" do
        let(:other_value) { existing_value }

        it { should be_true }
      end

      context "when the value is not stored in the list" do
        let(:other_value) { double }

        it { should be_false }
      end
    end
  end

  context "with many entries" do
    before { number_of_existing_entries.times { list.add double } }

    let(:number_of_existing_entries) { 5 }

    its(:size) { should == number_of_existing_entries }
  end
end
