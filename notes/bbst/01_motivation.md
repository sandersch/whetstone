# Balanced Binary Search Trees: Motivation

## Sorted Arrays: Supported Operations

| Operations                                               | Running Time |
| ---                                                      | ---          |
| Search                                                   | `O(log n)`   |
| Select (given order statistic `i`)                       | `O(1)`       |
| Min/Max                                                  | `O(1)`       |
| Predecessor/Successor                                    | `O(1)`       |
| Rank (i.e., # of keys less than or equal to given value) | `O(log n)`   |
| Output in sorted order                                   | `O(n)`       |

But what about insertions and deletions? Would take `O(n)` time

## Balanced Search Trees: Supported Operations

### Motivation

Like sorted array + fast (logarithmic) inserts and deletes!

| Operations             | Running Time |
| ---                    | ---          |
| Search                 | `O(log n)`   |
| Select                 | `O(log n)`   |
| Min/Max                | `O(log n)`   |
| Predecessor/Successor  | `O(log n)`   |
| Rank                   | `O(log n)`   |
| Output in sorted order | `O(n)`       |
| Insert (**New!**)      | `O(log n)`   |
| Delete (**New!**)      | `O(log n)`   |
