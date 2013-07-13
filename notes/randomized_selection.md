# Randomized Selection

## The Problem

### Input

array A with n distinct numbers and a number i in { 1, 2, ... , n }

### Output

i-th order statistic (i.e., i-th smallest element of input array)

### Example

median

```
i = (n+1)/2 for n od, i = n/2 for n even
```

## Reduction to Sorting

### O(n log n) algorithm

1. apply MergeSort
2. return i-th element of sorted array

### Fact

Can't sort any faster
