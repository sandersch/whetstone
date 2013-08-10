# Overview of Computer Architecture

* Instructions
* Memory System
* Processor Bus and IO Subsystem
* Disk System
* GPU and Graphics System
* Network

This overview only covers Instructions and the Memory System

## Intel Nehalam Microarchitecture

* [Wikipedia](http://en.wikipedia.org/wiki/Nehalem_(microarchitecture))
* [Diagrams](http://www.qdpma.com/cpu/cpu_nehalem.html)

## Pipelining Execution

[Wikipedia](http://en.wikipedia.org/wiki/Instruction_pipeline)

### Limits to Pipelining

Hazards prevent next instruction from executing during its designated clock cycle

* **Structural Hazards** &ndash; attempt to use the same hardware to do two different things at once
* **Data Hazards** &ndash; instruction depends on result of prior instruction still in the pipeline
* **Control Hazards** &ndash; Caused by delay between the fetching of instructions and decisions about changes in control flow (branches and jumps)

#### Data Hazards

##### Data Hazards: True Dependence

* `Instr1` is _data dependent_ (aka _true dependence_) on `Instr0`
* If two instructions are data dependent, they cannot execute simultaneously, be completely overlapped or execute out-of-order
* If data dependence caused a hazard in pipeline, it is called a _Read After Write (RAW) hazard_

#### Name Dependence #1: Anti-dependence

* _Name Dependence_ &ndash; when 2 instructions use same register or memory location, called a _name_, but no flow of data between the instructions associated with that name; _2 versions of name dependence_
* `InstrA` writes operand _before_ `InstrB` reads it
* Called an _anti-dependence_ by compiler writers. This results from reuse of the same register location, e.g. `rax`
* If anti-dependence caused a hazard in pipeline, it is called a _Write After Read (WAR) hazard_

#### Name Dependence #2: Output Dependence

* `InstrA` writes operand _before_ `InstrB` writes it.
* Called an _output dependence_ by compiler writers. This also results from reuse of the same register location, e.g. `rax`
* If anti-dependence caused a hazard in the pipeline, it is called _Write After Write (WAW) hazard_
* Instructions involved in a name dependence can execute simultaneously if name used in instructions is changed so instructions do not conflict
  * _Register renaming_ resolves name dependence for registers
  * Renaming can be done either by compiler or HW

#### Control Hazards

* Every instruction is control dependent on some set of branches, and generally these control dependencies must be preserved to preserve program order.
* Control dependence need not be preserved
  * willing to execute instructions that should not have been executed, thereby violating the control dependencies, if can do so without affecting the correctness of the program
* Speculative Execution

### Superscalar Execution

Execute instructions on different data types in parallel

### ILP and Data Hazards

* Finds Instruction Level Parallelism
  * Multiple instructions issues in parallel
* HW/SW must preserve program order: order instructions would execute in if executed sequentially as determined by original source program
  * Dependences are a property of programs
* Importance of the data dependences
  1. indicates the possibility of a hazard
  2. determines order in which results must be calculated
  3. sets an upper bound on how much parallelism can possibly be exploited
* **Goal** &ndash; exploit parallelism by preserving program order only where it affects the outcome of the program

### Out of Order Execution

Issue varying numbers of instructions per clock

* dynamically scheduled 
  * Extracting ILP by examining 100s of instructions
  * Scheduling them in parallel as operands become available
  * Rename register to eliminate anti and dependencies
  * out-of-order execution
  * Speculative execution

### Speculation

Different predictors

* Branch prediction
* Value prediction
* Prefetching (memory access pattern protection)

Greater ILP: Overcome control dependence by hardware speculating on outcome of branches and executing program as if guesses were correct

* **Speculation** &ndash; _fetch, issue, and execute_ instructions as if branch predictions were always correct
* **Dynamic Scheduling** &ndash; only _fetches and issues_ instructions

Essentially a _data flow execution model_: Operations execute as soon as their operands are available

### Intel Core Microarchitecture &ndash; Branch Prediction

* Complex predictor
* Multiple predictors
  * Use branch history
  * Different algorithms
  * Vote at the end
* Indirect address predictor
* Return address predictor
* Nehalem and Sandybridge are even more complicated!

## Multimedia Instructions

* **SIMD** &ndash; In computing, _SIMD (Single Instruction, Multiple Data)_ is a technique employed to achieve data level parallelism, as in a vector or array processor
* Intel calls the latest version SSE, used to call it MMX
* Packaged data type
  * Separate register file
* Vectorization Converts Loops

## Memory System

* The principle of locality
  * Programs access a relatively small portion of the address space at any instant of time
* Two Different Types of Locality
  * **Temporal Locality (Locality of Time)** &ndash; If an item is referenced, it will tend to be referenced again soon (e.g. loops, reuse)
  * **Spatial Locality (Locality in Space)** &ndash; If an item is referenced, items whose addresses are close by tend to be referenced soon (e.g. straight-line code, array access)

For the last 30 years, HW relied on locality for memory performance.

### Levels of the Memory Hierarchy

[Wikipedia](http://en.wikipedia.org/wiki/Memory_hierarchy)

### Cache Issues

* Cold Miss
  * The first time the data is available
  * Prefetching may be able to reduce the cost
* Capacity Miss
  * The previous access has been evicted because too much data touched in between
  * "Working Set" too large
  * Reorganize the data access so reuse occurs before getting evicted
  * Prefetch otherwise
* Conflict Miss
  * Multiple data items mapped to the same location. Evicted even before cache is full
  * Rearrange data and/or pad arrays



