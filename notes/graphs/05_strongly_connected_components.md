# Strongly Connected Components

### Formal Definition

The strongly connected components (SCCs) of a directed graph G are the equivalence classes of the relation

    u ~ v <=> ∃ path u ---> v and
              a path v ---> a in G.

## Kosaraju's Two-Pass Algorithm

### Theorem

Can compute in SCCs in O(m+n) time.

### Algorithm

Given directed graph G:

  1. Let G^rev = G with all arcs reversed
  2. run DFS-loop on G^rev
     * let f(v) = _finishing time_ of each vertex.
     * **goal**: compute "magical ordering" of nodes
  3. run DFS-loop on G
     * processing node in decreasing order of fnishing time
     * **goal**: discover the SCCs one-by-one
     * SCCs = nodes with the same _leader_

### DFS-Loop

#### DFS-Loop (graph G)

  * global variable t = 0
    * for finishing times in first pass
    * num of nodes processed so far
  * global variable s = NULL
    * for leaders in second pass
    * current source vertex
  * Assume nodes lablled 1 to n.
    * for i = n down to 1
      * if i not yet explored
        * s := i
        * DFS(G, i)
  * t++
  * set f(i) := t 
    * i's finishing time

#### DFS (graph G, node i)

  * mark i as explored
  * set leader(i) := nodes
  * for each arc (i,j) ∈ G:
    * if j not yet explored:
      * DFS(G, j)
