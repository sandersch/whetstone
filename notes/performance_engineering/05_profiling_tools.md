# Profiling Tools

> Premature optimization is the root of all evil.

> _Donald Knuth_

* Should focus on optimizing **hotspots**
* **Profiling**: identifies where your code is slow

## What is the bottleneck?

* Could be:
  * **CPU**
  * **Memory**
  * Network
  * Disk
  * SQL DB
  * User Input
* Solution depends heavily on the problem
* Our discussion will focus on CPU and Memory

## Profiling Tools

|In order to do…        |You can use…                          |
|-----------------------|--------------------------------------|
|Manual Instrumentation |`printf`, (or fancy variants thereof) |
|Static Instrumentation |`gprof`                               |
|Dynamic Instrumentation|`callgrind`, `cachegrind`, `DTrace`   |
|Performance Counters   |`oprofile`, `perf`                    |
|Heap Profiling         |`massif`, `google-perftools`          |

Other tools exist for Network, Disk IO, Software-specific, etc…

## Event Sampling

* Basic Idea
  * Keep a list of where "interesting events" (cycle, branch miss, etc) happen
* Actual Implementation
  * Keep a counter for each event
  * When a counter reaches threshold, fire interrupt
  * Interrupt handler: Record execution context
* A tool (e.g. `perf`) turns data into useful reports

## Intel Performance Counters

* CPU Feature: Counters for hundreds of events
  * Performance: cache misses, branch misses, instructions per cycle, …
  * CPU sleep states, power consumption, etc (not typically directly related to performance)
* We will discuss most useful CPU performance counters
* [Intel 64 and IA-32 Architectures Software Developer's Manual](http://www.intel.com/content/www/us/en/processors/architectures-software-developer-manuals.html)
  * Appendix A lists all counters

## Linux: Performance Counter Subsystem

* New event sampling tool (2.6.31 and above)
  * Older tools: `oprofile`, `perfmon`
* Can monitor software and hardware events
  * Show all predefined events: `perf list`
  * Define your own performance counters…
  * Part of `linux-tools-common` package on Ubuntu
