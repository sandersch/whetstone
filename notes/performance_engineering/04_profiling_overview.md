# Profiling

Helps identify and characterize performance issues by:

* Collecting performance data from the system running your application.
* Organizing and displaying the data in a variety of interactive views, from system-wise down to source code or processor instruction perspective.
* Identifying potential performance issues and suggesting improvements.

Examples: Intel `Vtune`, `gprof`, `oprofile`, `perf`

## What is a Hotspot?

**Where** in an application or system that there is a **significant** amount of **activity**

#### Where
  * Address in memory
  * OS process
  * OS thread
  * Executable file or _module_
  * User function (requires symbols)
  * Line of source code (requires symbols with line numbers) or assembly instruction

#### Significant
  * Activity that occurs infrequently probably does not have much impact on system performance

#### Activity
  * Time spent or other internal processor event
  * Examples of other events: cache misses, branch mispredictions, floating-point instructions retired, partial register stalls, and so on.

### Two Ways to Track Location

#### Problem

I need to know where you spend _most_ of your time.

#### Statistical Solution

I call you on your cellular phone every 30 minutes and ask you to report your location. Then I plot the data as a histogram.

#### Instrumental Solution

I install a special phone booth at the entrance of every site you plan to visit. As you enter or exit every site, you first go into the booth, call the operator to get the exact time, and then call me and tell me where you are and when you got there.

### Sampling Collector

Periodically interrupt the processor to obtain the execution content

* Time-based sampling (TBS) is triggered by:
  * Operating system timer services
  * Every _n_ processor clockticks
* Event-based sampling (EBS) is triggered by processor event counter overflow.
  * These events are processor-specific, like L2 cache misses, branch mispredictions, floating-point instructions retired, and so on.

### The Statistical Solution: Advantages

* No installation Required
  * No need to install a phone everywhere you want a man in the field to make a report
* Wide Coverage
  * Assuming all his territory has cellular coverage, you can track him wherever he goes
* Low Overhead
  * Answering his cellular telephone once in a while, reporting his location, and returning to other tasks do not take much of his time

### The Statistical Solution: Disadvantages

* Approximate Precision
  * A number of factors can influence exactly how long he takes to answer the phone
* Limited Report
  * Insufficient time to find out how he got to where he is or where he has been since you last called him

> **Statistical Significance**: There are some places you might no locate him, if he does not go there often or he does not stay very long. Does that really matter?

> **No.** If he doesn't go there often and/or stay there long, then those places have little effect on performance

### The Instrumentation Solution: Advantages

* Perfect Accuracy
  * I know where you were immediately before and after your visit to each customer
  * I can calculate how much time you spent at each customer site
  * I know how many times you visited each customer site

### The Instrumentation Solution: Disadvantages

* Low Granularity
  * Too coarse, the site is the site
* High Overhead
  * You spend valuable time going to phone booths, calling operators, and calling me
* High Touch
  * I have to build all those phone booths, which expands the space in each site you visit

### Use Event Ratios

* In isolation, events may not tell you much.
* Event ratios are dynamically calculated values based on events that make up the formula
  * Cycles per instruction (CPI) consists of clockticks and instructions retired
* There are a wide variety of predefined event ratios
