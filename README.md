# thread-safety-experiments

An experimentation of various strategies for thread-safe access to some global value, using [swift-measure](https://github.com/tgrapperon/swift-measure)

```
== Thread Safety Experiments ==================================================================
                                    Value  Difference Variation  Performance  Error  Iterations
-- Thread Safe Value Access - Get -------------------------------------------------------------
Direct Access                   (*)  51 ns                                   ±0.24 %    1000000
Main Thread Check                    55 ns      +5 ns    +9.00 %       x0.92 ±1.07 %    1000000
Thread.current.threadDictionary     442 ns    +391 ns  +773.77 %       x0.11 ±0.09 %    1000000
NSRecursiveLock                      81 ns     +30 ns   +59.83 %       x0.63 ±0.17 %    1000000
@TaskLocal                           62 ns     +12 ns   +23.45 %       x0.81 ±0.18 %    1000000
Actor                               583 ns    +532 ns +1052.44 %       x0.09 ±0.43 %    1000000
-- Thread Safe Value Access - Set -------------------------------------------------------------
Direct Access                   (*)  55 ns                                   ±0.19 %    1000000
Main Thread Check                    62 ns      +7 ns   +11.85 %       x0.89 ±0.22 %    1000000
Thread.current.threadDictionary     456 ns    +401 ns  +726.31 %       x0.12 ±0.08 %    1000000
NSRecursiveLock                      88 ns     +33 ns   +59.75 %       x0.63 ±0.15 %    1000000
@TaskLocal                          263 ns    +208 ns  +376.72 %       x0.21 ±0.11 %    1000000
Actor                               554 ns    +499 ns  +904.69 %       x0.10 ±0.19 %    1000000
===============================================================================================
```

Results obtained with Xcode 13.3b1, Swift 5.6, Release build, on MacOS Monterey 12.2

4Ghz Core i7 4790K, late 2014 iMac Retina 5K, 16 GB 1600 MHz DDR3
