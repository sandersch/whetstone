# Bentley's Rules for Modifying Code for Performance

1. Loop Rules
2. Logic Rules
3. Procedure Rules
4. Expression Rules
5. Parallelism Rules

## Loop Rules

1. Loop Invariant Code Motion
2. Sentinel Loop Exit Test
3. Loop Elimination by Unrolling
4. Partial Loop Unrolling
5. Loop fusion
6. Eliminate wasted iterations

### Loop Invariant Code Motion

Move as much of the code as possible out of the loops. Compilers do a good job today.

* Analyzable code
* Provably results are the same in every iteration
* Provably no side effects

#### When is this viable?

* Loop invariant computation that compiler cannot find
* The cost of keeping the value in a register is amortized by the savings

### Sentinel Loop Exit Test

When we iterate over data to find a value, we have to check the end of the data as well as for the value.

Add an extra data item at the end that matches the test.

#### When is this viable?

* Early loop exit condition that can be harnessed as the loop test
* When an extra data item can be added at the end
* Data array is modifiable

### Loop Elimination by Unrolling

Known loop bounds -> can fully unroll the loop.

#### Benefits

* Eliminate overhead of loop test
* Enable parallelization of computation using SIMD
* Can get compiler to do this

#### When is this viable?

* Smaller number of iterations (code blow-up is manageable)
* Small loop body (code blow-up is manageable)
* Little work in the loop body (loop test cost is not trivial)

#### Example

```
sum = 0;
for(i=0; i<10; i++)
  sum = sum + A[i];
```

is unrolled as:

```
sum = A[0] + A[1] + A[2]+ A[3] + A[4] + A[5] + A[6] + A[7] + A[8] + A[9];
```

### Partial Loop Unrolling

Make a few copies of the loop body. Similar benefits to full unrolling

#### When is this viable?

* Work in the loop body is minimal (viable impact of running the loop test fewer number of times)
* Or the ability to perform optimizations on combine loop bodies

#### Example

```
sum = 0;
for(i=0; i<n; i++)
  sum = sum + A[i];
```

is unrolled as:

```
sum = 0;
for(i=0; i<n-3; i+=4)
  sum += A[i] + A[i+1] + A[i+2] + A[i+3];
for(; i<n; i++)
  sum += A[i];
```

### Loop Fusion

When multiple loops iterate over the same set of data, put the computation in one loop body.

#### When is this viable?

* No aggregate from one loop is needed in the next
* Loop bodies are manageable

#### Example

```
amin = INTMAX;
for(i=0; i<n; i++)
  if(A[i] < amin) amin = A[i];

amax = INTMIN;
for(i=0; i<n; i++)
  if(A[i] > amax) amax = A[i];
```

can be improved to:

```
amin = INTMAX;
amax = INTMIN;
for(i=0; i<n; i++)
  int atmp = A[i];
  if(atmp < amin) amin = A[i];
  if(atmp > amax) amax = A[i];
```

### Eliminate Wasted Iterations

Change the loop bounds so that it will not iterate over a empty loop body

#### When is this viable?

* For a lot of iterations the loop body is empty
* Can change the loop bounds to make the loop tighter
* Or ability to change the data structures around (efficiently and correctly)

## Logic Rules

1. Exploit Algebraic Identities
2. Short Circuit Monotone functions
3. Reordering tests
4. Precompute Logic Functions
5. Boolean Variable Elimination

### Exploit Algebraic Identities

If the evaluation of a logical expression is costly, replace algebraically equivalent

#### Examples

```
sqr(x) > 0                        -> x != 0
sqrt(x*x + y*y) < sqrt(a*a + b*b) -> x*x + y*y < a*a + b*b
ln(A) + ln(b)                     -> ln(A*B)
sin(x) * sin(x) + cos(x) * cos(x) -> 1
```

### Short Circuit Monotone Functions

In checking if a monotonically increasing function is over a threshold, don't evaluate beyond a threshold.

### Reordering Tests

Logical tests should be arranged such that inexpensive and often successful tests precede expensive and rarely successful ones. Add inexpensive and often successful tests before expensive ones

### Precompute Logic Functions

A logical function over a small finite domain can be replaced by a lookup in a table that represents the domain.

### Boolean Variable Elimination

Replace the assignment to a Boolean variable be replacing it by an IF-THEN-ELSE

#### Example

```
int v = Boolean Expression; -> if(Boolean Expression) {
                                 S1;
S1;                              S2;
if(v)                            S4;
  S2;                            S5;
else                           } else {
  S3;                            S1;
S4;                              S3;
if(v)                            S4;
  S5;                          }
```

## Procedure Rules

1. Collapse Procedure Hierarchies
2. Coroutines
3. Tail Recursion Elimination

### Collapse Procedure Hierarchies

Inline small functions into the main body.

* Eliminates overhead
* Provide further opportunities for compiler optimization

### Coroutines

Multiple passes over data should be combined. Similar to _Loop Fusion_, but at a scale and complexity beyond a single loop

### Tail Recursion Elimination

In a self recursive function, if the last action is calling itself, eliminate the recursion.

## Expression Rules

1. Compile-time Initialization
2. Common Subexpression Elimination
3. Paring Computation

### Compile-Time Initialization

If a value is a constant, make it a compile-time constant

* Save the effort of calculation
* Allow the value inlining
* More optimization opportunities

### Common Subexpression Elimination

If the same expression is evaluated twice, do it only once.

#### When is this viable?

* Expression has no side effects
* The expression value does not change between the evaluations
* The cost of keeping a copy is amortized by the complexity of the expression
* Too complicated for the compiler to do it automatically

### Pairing Computation

If two similar functions are called with the same arguments close to each other in many occasions, combine them.

* Reduce call overhead
* Possibility of sharing the computation cost
* More optimization possibilities

## Parallelism Rules

1. Exploit Implicit Parallelism
2. Exploit Inner Loop Parallelism
3. Exploit Coarse Grain Parallelism
4. Extra computation to create parallelism

### Exploit Implicit Parallelism

Reduce the loop carried dependences so that "software pipelining" can execute a compact schedule without stalls.

### Exploit Inner Loop Parallelism

Facilitate inner loop vectorization (for SSE type instructions)

How? By gingerly guiding the compiler to do so:

* Iterative process by looking at why the loop is not vectorized and fixing those issues
* Most of the rules above can be used to simplify the loop so that the compiler can vectorize it

### Exploit Coarse Grain Parallelism

* Outer loop parallelism (doall and doacross loops)
* Task parallelism
* Ideal for multicores
* You need to do the parallelism yourself

### Extra computation to create parallelism

In many cases doing a little more work (or a slower algorithm) can make a sequential program a parallel one. Parallel execution may amortize the cost.
