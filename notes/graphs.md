# Graphs

## Components

 * **vertices** aka **nodes** (V)
 * **edges** (E) = pairs of vertices
   * can be **undirected** [an unordered pair]
   * or **directed** [ordered pair], aka arcs
 * **Examples:** road networks, the web, social networks, precedence

## Cuts of Graphs

### Definition

a **cut** of a graph (V,E) is a partition of V into two non-empty sets of A and B.

### Definition

The **crossing edges** of a cut (A,B) are those with:

  * one endpoint in each of (A,B) [undirected]
  * tail in A, head in B [directed]

## The Minimum Cut Problem

### Input

  * An undirected graph G=(V,E)
  * parallel edges allowed

### Goal

compute a cut with the fewest number of crossing edges. (a **min cut**)

### A Few Applications

  * identify netowrk bottlenecks/weaknesses
  * community dtection in social networks
  * image segmentation
    * input = graph of pixels
    * use edge weight [(u,v) has large weight <=> "expect" u,v to come from same object]

