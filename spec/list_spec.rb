require 'list'

describe List do
  context "with no entries" do
    its(:size) { should == 0 }

    describe "adding an entry" do
      subject { described_class.new.add new_value }

      let(:new_value) { mock }

      its(:size) { should == 1 }
    end
  end

  context "with one entry" do
    before { subject.add existing_value }

    let(:existing_value) { mock }

    its(:size) { should == 1 }

    describe "adding an entry" do
      before { subject.add new_value }

      let(:new_value) { mock }

      its(:size) { should == 2 }
    end
  end

  context "with many entries" do
    before { number_of_existing_entries.times { subject.add mock } }

    let(:number_of_existing_entries) { 5 }

    its(:size) { should == number_of_existing_entries }
  end
end
