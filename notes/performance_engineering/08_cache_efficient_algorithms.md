# Cache-Efficient Algorithms

## Ideal-Cache Model

#### Features

* Two-level hierarchy
* Cache size of `M` bytes
* Cache-line length of `B` bytes
* Fully associative
* Optimal, omniscient replacement

#### Performance Measures

* _work_ `W` (ordinary running time)
* _cache misses_ `Q`

### How Reasonable are Ideal Caches?

#### "LRU" Lemma [ST85]

Suppose that an algorithm incurs Q cache misses on an ideal cache of size `M`. Then on a fully associative cache of size `2M` that uses the _least-recently used (LRU)_ replacement policy, it incurs at most `2Q` cache misses.

#### Implication

For asymptotic analyses, one can assume optimal or LRU replacement, as convenient

#### Software Engineering

* Design a theoretically good algorithm
* Engineer for detailed performance
  * Real caches are not fully associative
  * Loads and stores have different costs with respect to bandwidth and latency

### Tall Cache Assumption

`B ** 2 < c * M` for sufficiently small constant `c <= 1`

##### Example: Intel Core i7 (Nehalem)

* Cache-line length = 64 bytes
* L1-cache size = 32 KB

### What's Wrong with Short Caches?

An `n×n` matrix stored in row-major order may not fit in a short cache even if `n ** 2` < `c * M`! Such a matrix always fits in a tall cache, and if `n = Ω(B)`, it takes at most `Θ(n ** 2/B)` cache misses to load it in.

## Efficient Cache-Oblivious Algorithms

* No voodoo tuning parameters
* No explicit knowledge of caches
* Passively autotune
* Multilevel caches automatically
* Good in multiprogrammed environments
