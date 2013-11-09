require 'list'

describe List do
  subject { list }

  let(:list) { described_class.new }

  context "with no entries" do
    describe '#size' do
      subject { super().size }
      it { should == 0 }
    end

    describe "adding an entry" do
      subject { list.add new_value }

      let(:new_value) { double }

      describe '#size' do
        subject { super().size }
        it { should == 1 }
      end
    end

    describe "checking if the list contains a value" do
      subject { list.contains? other_value }

      let(:other_value) { double }

      it { should be_falsey }
    end
  end

  context "with one entry" do
    let(:list) { described_class.new existing_value }
    let(:existing_value) { double }

    describe '#size' do
      subject { super().size }
      it { should == 1 }
    end

    describe "adding an entry" do
      subject { list.add new_value }

      let(:new_value) { double }

      describe '#size' do
        subject { super().size }
        it { should == 2 }
      end
    end

    describe "checking if the list contains a value" do
      subject { list.contains? other_value }

      context "when the value is stored in the list" do
        let(:other_value) { existing_value }

        it { should be_truthy }
      end

      context "when the value is not stored in the list" do
        let(:other_value) { double }

        it { should be_falsey }
      end
    end
  end

  context "with many entries" do
    before { number_of_existing_entries.times { list.add double } }

    let(:number_of_existing_entries) { 5 }

    describe '#size' do
      subject { super().size }
      it { should == number_of_existing_entries }
    end
  end
end
