# Graphs

## Components

 * **vertices** aka **nodes** (V)
 * **edges** (E) = pairs of vertices
   * can be **undirected** [an unordered pair]
   * or **directed** [ordered pair], aka arcs
 * **Examples:** road networks, the web, social networks, precedence

## Representing Graphs

### Sparse vs. Dense Graphs

Let **n** = # of vertices, **m** = # of edges. In most (but not all) applications, m is Ω(n) an O( n^2 )

  * in a _sparse graph_, m is O(n) or close to it
  * in a _dense graph_, m is close to Ω( n^2 )

### An Adjacency Matrix

Represent G by a n x n 0-1 matrix A, where:

    A(i,j) = 1 <=> G has an i-j edge

#### Variants

  * A(i,j) = # of i-j edges (if parallel edges)
  * A(i,j) + **weight** of i-j edge (if any)
  * A(i,j) = +1 if i --> j, -1 if i <-- j

### Adjacency Lists

  * array (or list) of vertices [Ω(n)]
  * array (or list) of edges [Ω(m)]
  * each edge points to its endpoints [Ω(m)]
  * each vertex points to edges incident on it [Ω(m)]
  * total Ω(max{m,n})

### Comparison of Representations

Which is better?

  * Depends on graph density and operations needed

||Adjacency list|Incidence list|Adjacency matrix|Incidence matrix
---|---|---|---|---
**Storage**|O(n+m)|O(n+m)|O(n^2)|O(n•m)
**Add vertex**|O(1)|O(1)|O(n^2)|O(n•m)
**Add edge**|O(1)|O(1)|O(1)|O(n•m)
**Remove vertex**|O(m)|O(m)|O(n^2)|O(n•m)
**Remove edge**|O(m)|O(m)|O(1)|O(n•m)
**Query:** are vertices u, v adjacent? (Assuming that the storage positions for u, v are known)|O(n)|O(m)|O(1)|O(m)
**Remarks**|When removing edges or vertices, need to find all vertices or edges||Slow to add or remove vertices, because matrix must be resized/copied|Slow to add or remove vertices and edges, because matrix must be resized/copied


## Cuts of Graphs

#### Definition

a **cut** of a graph (V,E) is a partition of V into two non-empty sets of A and B.

#### Definition

The **crossing edges** of a cut (A,B) are those with:

  * one endpoint in each of (A,B) [undirected]
  * tail in A, head in B [directed]

### The Minimum Cut Problem

#### Input

  * An undirected graph G=(V,E)
  * parallel edges allowed

#### Goal

compute a cut with the fewest number of crossing edges. (a **min cut**)

#### A Few Applications

  * identify netowrk bottlenecks/weaknesses
  * community dtection in social networks
  * image segmentation
    * input = graph of pixels
    * use edge weight [(u,v) has large weight <=> "expect" u,v to come from same object]
