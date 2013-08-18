# Balanced Binary Search Trees: Basic Structure

## Binary Search Tree Structure

* Exactly one node per key
* Most basic version, each node has:
  * left child pointer
  * right child pointer
  * parent pointer

### Search Tree Property

Given an arbitrary node of tree, x:

* **Left** &ndash; all keys < x
* **Right** &ndash; all keys > x

Should hold at every node of the search tree.

### The Height of a BST

Many possible trees for a set of keys. _Height_ could be anywhere from approx.

* `log2(n)` for best case, perfectly balanced
* `n` for worst case, a chain

> _Height_ &ndash; also depth; longest root-leaf path

## Searching and Inserting

#### To SEARCH for key k in tree T

* start at the root
* traverse left/right child pointers as needed
  * left if `k` < key at current node
  * right if `k` > key at current node
* return node with key `k` or `null`, as appropriate

#### To INSERT a new key k into tree T

* search for k (unsuccessfully)
* rewire final `null` pointer to point to new node with key k
