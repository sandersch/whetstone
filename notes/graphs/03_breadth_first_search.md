# Breadth-First Search (BFS)

   * explore nodes in _layers_
   * can computed shortest paths
   * connected component of undirected graph
   * **Run Time:** O(m+n), linear time

## Implementation

BFS(graph G, start vertex s) [all nodes initially unexplored]

  * mark s as explored
  * let Q = queue data structure (fifo), initialized with s
  * while Q != []:
    * remove the first node of Q, call it v
    * for each edge (v,w):
      * if w unexplored
        * mark w as explored
        * add w to Q (at the end)

## Basic BFS Properties

#### Claim #1

at the end of BFS, v explored <=> G has a path from s to v.

#### Reason

special case of the generic algorithm

#### Claim #2

running time of main while loop = 

    O(ns, ms), where ns = number of nodes reachable from s
                     ms = number of edges reachable from s

## Application: Shortest Paths

### Goal

compute dist(v), the fewest number of edges on a path from s to v.

### Extra Code

  * initialize dist(v) = 0 if v = s, +∞ if v != s
  * when considering edge (v,w):
    * if w unexplored, then set dist(w) = dist(v) + 1.

### Claim

At termination, dist(v) = i <=> v in i^th layer (i.e. <=> shortest s-v path has i edges).

### Proof Idea

Every layer-i node w is added to Q by a layer - (i-1) node v via the edge (v,w).

## Application: Undirected Connectivity

Let G = (V,E) be an undirected graph.

  * **Connected components** = the _pieces_ of G.
  * **Formal definition**: equivalence classes of the relation u ~ v <=> ∃ u - v path in G. [check: ~ is an equivalence relation]

### Goal

Compute all connected components.

#### Why?

  * check if network is disconnected
  * graph visualization
  * clustering

### Connected Components via BFS

#### To Compute all Components (undirected case)

  * all nodes unexplored [assume labeled 1 to n]
  * for i := 1 to n
    * if i not yet explored
      * BFS(G, i)
         * discoveres precisly i's connected component

#### Note

Finds every connected component

#### Running Time

O(m+n)

