# Performance Engineering and Memory Systems

## Levels of the Memory Hierarchy

| Memory Type      | Amount Available | Access Time           | Cost     |
| ---              | ---              | ---                   | ---      |
| Registers        | 100s Bytes       | 300-500ps (0.3-0.5ns) |          |
| L1 and L2 caches | 10s-100s KBs     | ~1ns - ~10ns          | $100s/GB |
| DRAM memory      | GBs              | 80 ns-200ns           | ~$100/GB |
| Disk             | 10s TBs          | 10ms (10,000,000ns)   | ~$1/GB   |
| Tape             | infinite         | sec-min               | ~$1/GB   |

## Cache Issues

#### Cold Miss
* The first time the data is available
* Prefetching may be able to reduce the cost

#### Capacity Miss
* The previous access has been evicted because too much data touched in between
* "Working Set" too large
* Reorganize the data access so reuse occurs before getting evicted
* Prefetch otherwise

#### Conflict Miss
* Multiple data items mapped to the same location. Evicted even before cache is full.
* Rearrange data and/or pad arrays

#### True Sharing Miss
* Thread in another processor wanted the data, it got moved to the other cache
* Minimize sharing/locks

#### False Sharing Miss
* Other processor used different data in the same cache line. So the line got moved.
* Pad data and make sure structures such as locks don't get into the same cache line

## Simple Cache

1. 32KB, direct mapped, 64 byte lines (512 lines)
2. Cache access = single cycle
3. Memory access = 100 cycles
4. Byte addressable memory
5. How addresses map into cache
   1. Bottom 6 bites are offset in cache line
   2. Next 9 bits determine cache line
6. Successive 32KB memory blocks line up in cache

## Analytically Model Access Patterns

#### Example 1

```
#define S ((1<<20)*sizeof(int))
int A[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {   // Read in new line
  read A[i];              // Read rest of line
}                         // Move on to next line
```

* Array laid out sequentially in memory.
* Assume `sizeof(int) = 4`
* 16 elements of `A` per line
* 15 of every 16 hit cache
* What kind of locality? **Spatial**
* What kind of misses? **Cold**

#### Example 2

```
#define S ((1<<20)*sizeof(int))
int A[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {
  read A[0];              // Read A[0] every time
}
```

* `S` reads to `A`
* All (except first) hit in cache
* Total access time: `100 + (S-1)`
* What kind of locality? **Temporal**
* What kind of misses? **One cold miss**

#### Example 3

```
#define S ((1<<20)*sizeof(int))
int A[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {
  read A[i % (1<<N)];     // Read initial segment of A repeatedly
}
```

* `S` reads to `A`
* Assume `4 <= N <= 13`
* One miss for each accessed line
* Rest hit in cache
* How many accessed lines? `2 ** (N -1)`
* Total Access Time: `2 ** (N-1) * 100 + (S - 2 ** (N-1))`
* What kind of locality? **Temporal and Spatial**
* What kind of misses? **Cold**

#### Example 4

```
#define S ((1<<20)*sizeof(int))
int A[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {
  read A[i % (1<<N)];     // Read initial segment of A repeatedly
}
```

* `S` reads to `A`
* Assume 14 <= `N`
* First access to each line misses
* Rest accesses to that line hit
* Total Access Time: 
  * _(16 elements of A per line)_
  * _(15 of every 16 hit in cache)_
  * `15 * (S/16) + 100 * (S/16)`
* What kind of locality? **Spatial**
* What kind of misses? **Cold, Capacity**

#### Example 5

```
#define S ((1<<20)*sizeof(int))
int A[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {
  read A[i % (1<<N)];     // Read every 16th element of initial
}                         // segment of A, repeatedly
```

* `S` reads to `A`
* Assume 14 <= `N`
* 100% cache misses
* Total Access Time: `100 * S`
* What kind of locality? **None**
* What kind of misses? **Cold misses at the beginning, then conflict**

#### Example 6

```
#define S ((1<<20)*sizeof(int))
int A[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {
  read A[random()%S];     // Read random elements of A
}
```

* `S` reads to `A`
* Chance of hitting cache (roughly) = `8K/1G` = `1/256`
* Total Access Time (roughly): `S(255/256)*100 + S*(1/256)`
* What kind of locality? **Almost None**
* What kind of misses? **Cold, capacity, conflict**

## Branch Cache Access Modes

1. **No locality** &ndash; no locality in computation
2. **Streaming** &ndash; spatial locality, no temporal locality
3. **In cache** &ndash; most accesses to cache
4. **Mode shift for repeated sequential access**
   1. Working set fits in cache &ndash; in cache mode
   2. Working set too big for cache &ndash; streaming mode
5. **Optimizations for streaming mode**
   1. Prefetching
   2. Bandwidth provisioning (can buy bandwidth)

#### Example 7

```
#define S ((1<<19)*sizeof(int))
int A[S];
int B[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {
  read A[i], B[i];        // Read A and B sequentially
}
```

* `S` reads to `A`, `B`
* `A` and `B` interfere in cache
* Total access time: `2 * 100 * S`
* What kind of locality? **None**
* What kind of misses? **Cold, conflict**

#### Example 8

```
#define S ((1<<19+16)*sizeof(int))
int A[S];
int B[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {
  read A[i], B[i];        // Read A and B sequentially
}
```

* `S` reads to `A`, `B`
* `A` and `B` almost, but don't, interfere in cache
* Total access time: `2 * (15/16 * S + 1/16 * S * 100)`
* What kind of locality? **Spatial**
* What kind of misses? **Cold, Capacity**

## Set Associative Caches

1. Have sets with multiple lines per set
2. Each line in cache called a _way_
3. Each memory line maps to a specific set
4. Can be put into any cache in in its set
5. 32 KB cache, 64 byte lines, 2-way associative
   1. 256 sets
   2. Bottom six bits determine offset in cache line
   3. Next 8 bits determine set

#### Example 9

```
#define S ((1<<19)*sizeof(int))
int A[S];
int B[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {
  read A[i], B[i];        // Read A and B sequentially
}
```

* `S` reads to `A`, `B`
* `A` and `B` lines hit same way, but enough lines in way
* What kind of locality? **Spatial**
* What kind of misses? **Cold**

#### Example 10

```
#define S ((1<<19)*sizeof(int))
int A[S];
int B[S];
                          // Access Pattern Summary
for (i=0; i < S; i++) {
  read A[i], B[i], C[i];  // Read A and B sequentially
}
```

* `S` reads to `A`, `B`, and `C`
* `A`, `B` and `C` lines hit same way, but NOT enough lines in way
* Total access time (with LRU replacement): `3 * S * 100`
* What kind of locality? **Spatial**, but cache can't exploit it
* What kind of misses? **Cold, conflict**

## Linked Lists and the Cache

```
struct node {         // Struct layout puts
  int data;           // 4 struct node per cache line
  struct node *next;  // (alignment, space for padding)
};

sizeof(struct node) = 16;

for(c = 1; c != NULL; c = c->next++) {
  read c->data;
}
```

* Assume list of length `S`
* Access Pattern Summary: Depends on allocation/use
* Best case &ndash; everything in cache
  * total access time = `S`
* Next best case &ndash; adjacent (streaming)
  * total access time = `(3/4 * S + 1/4 * S * 100)`
* Worst case &ndash; random (no locality)
  * total access time = `100 * S`
* Concept of effective cache size
  * (4 times less for lists than for arrays)

## Structs and the Cache

```
struct node {         // 2 struct node per cache line
  int data;           // (alignment, space for padding)
  int more_data;
  int even_more_data;
  int yet_more_data;
  int flags;
  struct node *next;  
};

sizeof(struct node) = 32;

for(c = 1; c != NULL; c = c->next++) {
  read c->data;
}
```

* Assume list of length `S`
* Access Pattern Summary: Depends on allocation/use
* Best case &ndash; everything in cache
  * total access time = `S`
* Next best case &ndash; adjacent (streaming)
  * total access time = `(1/2 * S + 1/2 * S * 100)`
* Worst case &ndash; random (no locality)
  * total access time = `100 * S`
* Concept of effective cache size
  * (8 times less for lists than for arrays)

### Parallel Array Conversion

```
int data[MAXDATA];
int more_data[MAXDATA];
int even_more_data[MAXDATA];
int yet_more_data[MAXDATA];
int flags[MAXDATA];
int next[MAXDATA];

sizeof(struct node) = 32;

for(c = 1; c != -1; c = next[c]) {
  read data[c];
}
```

* Advantages:
  * Better cache behavior
  * (more working data fits in cache)
* Disadvantages:
  * Code distortion
  * Maximum size has to be known or
  * Must manage own memory

## Matrix Multiply

1. Representing matrix in memory
2. Row-major storage

  ```
  double A[4][4];
  A[i][j];
  ```
  or

  ```
  double A[16];
  A[i*4 + j];
  ```

3. What if you want column-major storage?

  ```
  double A[16];
  A[j*4 + i];
  ```

### Standard Matrix Multiply Code

```
for (i = 0; i < SIZE; i++) {
  for (j = 0; j < SIZE; j++) {
    for (k = 0; k < SIZE; k++) {
      C[i*SIZE+j] += A[i*SIZE+k] * B[k*SIZE+j];
    }
  }
}
```

Look at inner loop only:

* Only first access to `C` misses (temporal locality)
* `A` accesses have streaming pattern (spatial locality)
* `B` has no temporal or spatial locality

### How to get spatial locality for B

**Transpose** B first, then multiply. New code:

```
for (i = 0; i < SIZE; i++) {
  for (j = 0; j < SIZE; j++) {
    for (k = 0; k < SIZE; k++) {
      C[i*SIZE+j] += A[i*SIZE+k] * B[j*SIZE+k];
    }
  }
}
```

* Overall effect on execution time?
  * 11620 ms (original)
  * 2356 ms (after transpose)

### How to get temporal locality?

1. How much temporal locality should there be?
2. How many times is each element accessed? `SIZE` times
3. Can we rearrange computation to get better cache performance?
4. Yes, we can block it!
5. Key equations (here A(1:1), B(1:1) are submatrices

```text
B(1:1) … B(1:N) x B(1:1) … B(1:N) = Σ(k) A(1:k)*B(k:1) … Σ(k) A(1:k)*B(k:N) 
B(N:1) … B(N:N)   B(N:1) … B(N:N)   Σ(k) A(N:k)*B(k:1) … Σ(k) A(N:k)*B(k:N) 
```

### Blocked Matrix Multiply

``` // Warning: SIZE must be a multiple of BLOCK
for (j = 0; j < SIZE; j += BLOCK) {
  for (k = 0; k < SIZE; k += BLOCK) {
    for (i = 0; i < SIZE; i += BLOCK) {
      for (ii = 0; ii < i+BLOCK; ii += BLOCK) {
        for (jj = 0; jj < j+BLOCK; jj++) {
          for (kk = 0; kk < k+BLOCK; kk++) {
            C[ii*SIZE+jj] += A[ii*SIZE+kk] * B[jj*SIZE+kk];
} } } } } }
```

* Overall effect on execution time?
  * 11620 ms (original), 2356 ms (after transpose), 

#### Data Reuse in Blocking

* Change of computation order can reduce the # of loads to cache
* Calculating a row (1024 values of A)
  * `A: 1024*1 = 1024 + B: 384*1 = 394 + C: 1024*384 = 393_216 = 394,524`
* Blocked Matrix Multiply (`32**2 = 1024 values of A`)
  * `A: 32*32 = 1024 + B: 384*32 = 12_284 + C: 32*384 = 12_284 = 25,600`

### Blocking for Multiple Levels

1. Can block for registers, L1 cache, L2 cache, etc.
2. Really nasty code to write by hand
3. Automated by compiler community
4. Divide and conquer an alternative (coming up)

## Call Stack and Locality

```
int fib(int n) {
  if(n == 0) return 1;
  if(n == 1) return 1;
  return (fib(n-1) + fib(n-2));
}
```

* What does call stack look like for `fib(4)`?
* How deep does it go?
* What kind of locality?

## Stages and Locality

1. Staged computational pattern
   1. Read in lots of data
   2. Process through State 1, … , Stage N
   3. Produce results
2. Improving cache performance
   1. For all cache-sized chunks of data
      1. Read in a chunk
      2. Process chunk through Stage 1, …, Stage N
      3. Produce results for chunk
   2. Merge chunks to produce results

## Basic Concepts

#### Cache Concepts

* Lines, associativity, sets
* How addresses map to cache

#### Access Pattern Concepts

* Streaming versus in-cache versus no locality
* Mode switches when working set no longer fits in cache

#### Data Structure Transformations

* Segregate and pack frequently accessed data
  * Replace structs with parallel arrays, other split data structures
  * Pack data to get smaller cache footprint
* Modify representation; Compute,; Restore representation
  * Transpose; Multiply; Transpose
  * Copy In; Compute; Copy Out

#### Computational Transforms

* Reorder data accesses for reuse
* Recast computation stages when possible
