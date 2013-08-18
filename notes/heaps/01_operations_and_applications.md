# Heap Operations and Applications

## Supported Operations

A container for objects that have keys. For example: employee records, network edges

#### Insert

* Add a new object to a heap
* Running time: `O(log n)`

#### Extract-Min

* Remove an object in heap with a minimum key value 
* Equally well, _Extract-Max_
* Ties broken arbitrarily
* Running time: `O(log n)`, where `n` = # of objects in heap

#### Heapify (non-essential)

* `n` batched _inserts_
* Running time: `O(n)`

#### Delete (non-essential)

* Remove element
* Running time: `O(log n)`

## Application: Sorting

#### Canonical use of heap

Fast way to do repeated minimum computations

#### Example

Selection Sort =~ `O(n)` linear scans, `O(n**2)` runtime on array of length `n`

### Heap Sort

1. _Insert_ all `n` array elements into a heap
2. _Extract-Min_ to pluck at elements in sorted order

#### Running Time

`2n` heap operations = `O(log n)` time

> Optimal for a _omparison-based_ sorting algorithm!

## Application: Event Manager

### Priority Queue

Synonym for a heap

#### Example

Simulation (e.g. for a video game)

* **object** &ndash; event records [action/update to occur at given time in the future]
* **key** &ndash; time event scheduled to occur
* **Extract-Min** &ndash; yields the next scheduled event

## Application: Median Maintenance

#### I Give You

A sequence, `x(1), … , x(n)` of numbers, one-by-one

#### You Tell Me

At each time step `i`, the median of `{ x(1), … , x(i) }`

#### Constraint

Use `O(log i)` time at each step `i`

#### Solution

Maintain heaps: 

* `H-low`: supports _Extract-Max_
* `H-high`: supports _Extract-Min_

### Key Idea

Maintain invariant that =~ `i/2` smallest (largest) elements in `H-low` (`H-high`)

## Application: Speeding Up Dijkstra

### Dijkstra's Shortest-Path Algorithm

* Naive implementation -> runtime = `O(n*m)` [`n` = vertices, `m` = edges]
* With heaps -> runtime = `O(m log n)`
