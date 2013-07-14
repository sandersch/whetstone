# Graph Search

## A Few Motivations

  1. check if a network is connected (can get to anywhere from anywhere else). Like the Kevin Bacon number game
  2. driving direction
  3. formulate a plan [e.g. how to fill in a Sudoku puzzle]
     * nodes = a partially completed puzzle
     * arcs  = filling in on new square
  4. compute the _pieces_ (or _components_) of a graph
     * clustering, structure of the Web graph, etc.

## Generic Graph Search

### Goals

  1. find everything findable from a given start vertex
  2. don't explore anything twice
  3. O(m+n) time

### Generic Algorithm

  * Given graph G, vertex, s
  * initially s explored, all other vertices unexplored
  * while possible:
    * choose an edge (u,v) with u explored and v unexplored
    * mark v explored
    * if none, halt

#### Claim

At end of the algorithm, v explored <=> G has a path from s to v. (G undirected or directed)

#### Proof

  * => easy induction on number of iterations
  * <= By contradiction. Suppose G has a path P from s to v:

          o   o   o   o   o   v
         / \ / \ / \ / \ / \ /
        s   o   o   o   o   o

  * But v unexplored at end of the algorithm. Then ∃ an edge (u,w) ∈ P with u explored and w unexplored
  * But then algorithm would not have terminated => Contradiction!

## BFS vs. DFS

How to choose among the possibly many "frontier" edges?

### Breadth-First Search (BFS)

  * explore nodes in _layers_
  * can compute shortest path
  * can compute connected components of an unidrected graph
  * O(m+n) time using a queue (fifo)

### Depth-First Search (DFS)

  * explore aggressively like a maze, backtrack only when necessary
  * compute topological ordering of directed acyclic graph
  * compute connected components in directed graphs
  * O(m+n) time using a stack (lifo), or via recursion

