# Balanced Binary Search Trees: Implementing Operations

## Min, Max, Pred, and Succ

### To Compute the MINimum Key of a Tree

* start at root
* follow left child pointers until you can't anymore
* return last key found

### To Compute PREDecessor of Key K

* easy case: if `k`'s left subtree is nonempty, return max key in left subtree
* otherwise: follow parent pointers until you get to a key less than `k`

## In-Order Traversal

### To Print Out Keys in Increasing ORer

* let `r` = root of search tree, with subtrees TL and TR
* recurse on TL [by recursion/induction, prints out keys of TL in increasing order]
* print out `r`'s key
* recurse on TR [prints out keys of TR in increasing order]
* Running time: `O(1) * n` recursive calls -> `O(n)` overall

## Deletion

### To Delete a Key K from a Search Tree
* SEARCH for `k`

#### Easy Case: (`k` has no children)
* just delete `k`'s node from tree, done

#### Medium Case: (`k`'s node has one child)
* just "spike out" `k`'s node (unique child assumes position previously held by `k`'s node)

#### Difficult Case (`k`'s node has 2 children)
* compute `k`'s predecessor `l` [i.e., traverse `k`'s (non-NULL) left child pointer, then right child pointers until no longer possible]
* SWAP `k` and `l`!

> **Note**: in its new position, `k` has no right child! -> easy to delete or spike out `k`'s new node

### Running Time

`O(height)`

## Select and Rank

#### Idea

Store a little bit of extra info at each tree node _about the tree itself_ (i.e., not about the data)

#### Example Augmentation

`size(x)` = # of tree nodes in subtree rooted at x

> **Note**: if `x` has children `y` and `z`, then `size(x) = size(y) + size(z) + 1`

### To SELECT i-th order statistic from Augmented Search Tree (with subtree sizes)

* start at root `x`, with children `y` and `z`
* let `a = size(y)` [`a = 0` if `x` has no left child]
* if `a = i - 1` return `x`'s key
* if `a >= i` recursively compute `i`-th order statistic of search tree rooted at `y`
* if `a < i - 1` recursively compute `(i - a - 1)`-th order statistic of search tree rooted at `z`
