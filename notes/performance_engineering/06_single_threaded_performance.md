# Single-Threaded Performance

#### Today's computing milieu: networks of multicore clusters

* Shared memory among processors within a chip
* Message passing among machines in a cluster
* Network protocols among clusters

#### Why study single-threaded performance?

* Foundation of good performance is making single threads execute fast.
* Lesson of single-threaded performance often generalize.

## Generic Single-Threaded Machine

| Processor Core                                       | Memory Hierarchy         |
| ---                                                  | ---                      |
| Registers                                            | Registers                |
| Functional units (arithmetic and logical operations) | L1-caches (instr & data) |
| Floating-point units                                 | L2-caches                |
| Vector units                                         | L3-caches                |
| Instruction execution and coordination               | DRAM memory              |
|                                                      | Solid-state drive        |
|                                                      | Disk                     |

## Source Code to Execution

  1. Input source code (e.g. `fib.c`)
  2. Compiled to machine code (4 stages)
    1. Preprocessing
    2. Compiling
    3. Assembling
    4. Linking
  3. Results in machine code `fib`
  4. Which is interpreted by hardware when run `./fib`
  5. Hardware executes instructions
