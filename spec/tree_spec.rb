require 'tree'

describe Tree::Node do
  subject { described_class.new value }

  let(:value) { mock :value }

  its(:value) { should == value }
end
