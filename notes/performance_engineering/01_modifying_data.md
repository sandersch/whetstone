# Bentley's Rules for Modifying Data for Performance

1. Space for Time
2. Time for Space
3. Space and Time

## Trading Space for Time

1. Data Structure Augmentation
2. Storing Precomputed Results
3. Caching
4. Lazy Evaluation

### Data Structure Augmentation

Add some more info to the data structures to make common operations quicker

#### When is this viable?

* Additional information offers a clear benefit
* Calculating the information is cheap/easy
* Keeping the information current is not too difficult

#### Examples

* **Faster Navigation** &ndash; Doubly linked list and Delete Operation
* **Reduced Computation** &ndash; Reference counting

### Storing Precomputed Results

Store the results of a previous calculation. Reuse the precomputed results instead of redoing the calculation.

#### When is this viable?

* Function is expensive
* Function is heavily used
* Argument space is small
* Results only depend on the arguments
* Function has no side effects
* Function is deterministic

#### Example

`lib/perf/precompute.rb`

### Caching

Store some of the heavily used/recently used results so they don't need to be computed

#### When is this viable?

* Function is expensive
* Function is heavily used
* Argument space is large
* There is a temporal locality in accessing the arguments
  * **Temportal Locality** &ndash; the same values are used multiple times in a time period
* A single hash value can be calculated from the arguments
* There exists a "good" hash function
  * **Good** &ndash; not many collisions; good distribution
* Results only depend on the arguments
* Function has no side effects
* Coherence
  * Is required:
    * Ability to invalidate the cache when results change
    * Function is deterministic
  * Or stale data can be tolerated for a while

### Lazy Evaluation

Defer the computation until the results are really needed

#### When is this viable?

* Only a few results of a large computation are ever used
* Accessing the results can be done by a function call
* The result values can be calculated incrementally
* All the data needed to calculate the results will remain unchanged or can be packaged-up

#### Example

`lib/perf/lazy.rb`

## Trading Time for Space

1. Packing/Compression
2. Interpreters

### Packing/Compression

Reduce the space of the data by storing them as "processed" which will require additional computation to get the data.

#### When is this viable?

* Storage is at a premium
  * Old days: most of the time!
  * Now
    * Embedded devices with very little memory/storage
    * Very large data sets
* Ability to drastically reduce the data size in storage
* Extraction process is amenable to the required access pattern
  * Batch - expand it all
  * Stream
  * Random access

#### Packing Level

* Packing in memory
* Packing out of core storage

#### Packing Methods

* Use smaller data size
* Eliminate leading zeros
* Eliminate repetitions (LZ77)
* Heavyweight compression

### Interpreters

Instead of writing a program to do a computation, use a language to describe the computation at a high level and write an interpreter for that language

#### Benefits

* Nice and clean abstraction of the language
* Easy to add/change operations by changing the high-level language program
* Much more compact representation

#### Examples

* String processing, e.g. regular expressions
* Bytecodes

## Improving Space and Time

Have your cake and eat it too

### SIMD

* Store short width data packed into the machine word (modern machines are usually 64 bit)
  * 64 booleans (unsigned long long)
  * 2 32-bit floats
  * 2 32-bit integers
  * 4 16-bit integers
  * 8 8-bit integers

* Single operation on all the data items
* Win-win situation both faster and less storage

#### When is this viable?

* If the same operation is performed on all the data items
* Items can be stored contiguous in memory
* Common case doesn't have to pick or operate on each item separately

