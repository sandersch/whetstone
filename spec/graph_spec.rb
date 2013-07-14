require 'graph'

describe Graph do
  subject { graph }

  let(:graph) { described_class.new(input) }

  context "an empty graph" do
    let(:input) { [] }

    its(:size) { should == 0 }
  end

  context "a simple graph" do
    let(:input) { [[1], [0,2], [1]] }
    let(:vertex) { 1 }

    its(:size) { should == input.size }

    describe "checking if two vertices are connected" do
      subject { graph.connected?(here_vertex, there_vertex) }

      describe 'recognizes that v0 is connected to v1' do
        let(:here_vertex) { 0 }
        let(:there_vertex) { 1 }

        it { should be_true }
      end

      describe 'knows that v2 is not connected to v0' do
        let(:here_vertex) { 2 }
        let(:there_vertex) { 0 }

        it { should be_false }
      end
    end

    describe "getting the neighbors of a vertex" do
      subject { graph.neighbors_of vertex }


      it { should == input[vertex] }
    end

    describe "a breadth-first search" do
      subject { graph.bfs vertex }

      it { should == [1, 0, 1] }
    end
  end

  context "a non-trivial graph" do
    let(:input) do [
      [1,3],       # 0
      [0,4,2],     # 1
      [1,5],       # 2
      [0,4,6],     # 3
      [1,3,6],     # 4
      [2,8],       # 5
      [3,4,9],     # 6
      [8,9,10,11], # 7
      [5,7,10,11], # 8
      [6,7,10],    # 9
      [7,8,9,11],  # 10
      [7,8,10]     # 11
    ]
    end

    its(:size) { should == input.size }

    describe "checking if two vertices are connected" do
      subject { graph.connected?(here_vertex, there_vertex) }

      describe 'recognizes that v0 is connected to v1' do
        let(:here_vertex) { 0 }
        let(:there_vertex) { 1 }

        it { should be_true }
      end

      describe 'knows that v2 is not connected to v4' do
        let(:here_vertex) { 2 }
        let(:there_vertex) { 4 }

        it { should be_false }
      end

      describe "a breadth-first search" do
        subject { graph.bfs vertex }
        let(:vertex) { 0 }

        it { should == [
          0, 1, 2,
          1, 2, 3,
          2, 4, 4,
          3, 4, 5,
        ] }
      end
    end
  end
end
