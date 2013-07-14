# Depth-First Search (DFS)

## Overview

Explore aggressively, only backtrack when necessary.

  * also computes a topological ordering of a directed acyclic graph
  * and stronly connected components of directed graphs

### Run Time

O(m+n)

## Implementation

### Exercise

mimic BFS code, use a stack instead of a queue [+ other minor modifications].

### Recursive Version

DFS(graph G, start vertex s)

  * mark s as explored
  * for every edge (s,v):
    * if v unexplored
      * DFS

## Basic DFS Properties

### Claim #1

At end of the algorithm, v marked as explored <=> ∃ path from s to v in G.

#### Reason

Particular instantiation of generic search procedure.

### Claim #2

Running time is O(ns + ms)

#### Reason

Look at each node in connected component of s at most once, each edge at most twice.

## Application: Topological Sort

### Definition

A **topological ordering** of a directed graph G is a labelling f of G's nodes such that:

  1. the f(v)'s are the set { 1, 2, ... , n }
  2. (u,v) ∈ G => f(u) < f(v)

### Motivation

Sequence tasks while respecting all precedence constraints.

#### Note

G has directed cycle => no toplogical ordering.

#### Theorem

No directed cycle => can compute topological ordering in O(m+n) time

### Straightforward Solution

#### Note

Every directed acyclic graph has a **sink vertex**

#### Reason

If not, can keep following outgoing arcs to produce a directed cycle.

#### To compute topological ordering

  * let v be a sink vertex of G
  * set f(v) = n
  * recurse on G - {v}

#### Why does it work?

When v is assigned to position i, all outgoing arcs already delted => all lead to later vertices in ordering
