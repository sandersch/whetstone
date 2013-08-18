# Heap Implementation

## The Heap Property

### Conceptually

Think of a heap as a tree

> _Rooted_, _binary_, as _complete_ as possible

### Heap Property

At every node `x`, `key[x]` <= all keys of `x`'s children

### Consequence

Object at root must have minimum key value

## Array Implementation

Think about heap as a tree, but store it in an array. We don't need pointers to determine parent-child relationships, but instead can just calculate based on the index.

```
parent(i) = floor(i/2)
children(i) = [2i, 2i + 1]
```

### Insert and Bubble-Up

#### Implementation of Insert (given key k)

1. stick `k` at end of last level
2. _Bubble-Up_ `k` until heap property is restored (i.e. key of `k`'s parent is <= `k`)

#### Extract-Min and Bubble-Down

##### Implementation of Extract-Min

1. Delete root
2. Move last leaf to be new root
3. Iteratively _Bubble-Down_ until heap property has been restored (always swap with **smaller** child!)

