# thread-safety-experiments

An experimentation of various strategies for thread-safe access to some global value, using [swift-measure](https://github.com/tgrapperon/swift-measure)

```
== Thread Safety Experiments ==================================================================
                                    Value  Difference Variation  Performance  Error  Iterations
-- Thread Safe Value Access - Get -------------------------------------------------------------
Direct Access                   (*)  30 ns                                   ±0.49 %    1000000
Main Thread Check                    33 ns      +3 ns   +10.57 %       x0.90 ±0.32 %    1000000
Thread.current.threadDictionary     421 ns    +390 ns +1298.00 %       x0.07 ±0.10 %    1000000
NSRecursiveLock                      69 ns     +39 ns  +128.43 %       x0.44 ±0.16 %    1000000
@TaskLocal                           46 ns     +16 ns   +53.03 %       x0.65 ±0.40 %    1000000
Actor                               599 ns    +569 ns +1891.52 %       x0.05 ±0.36 %    1000000
-- Thread Safe Value Access - Set -------------------------------------------------------------
Direct Access                   (*)  39 ns                                   ±0.40 %    1000000
Main Thread Check                    47 ns      +8 ns   +20.85 %       x0.83 ±0.38 %    1000000
Thread.current.threadDictionary     458 ns    +418 ns +1065.74 %       x0.09 ±0.16 %    1000000
NSRecursiveLock                      74 ns     +35 ns   +88.98 %       x0.53 ±0.20 %    1000000
@TaskLocal                          246 ns    +206 ns  +525.57 %       x0.16 ±0.09 %    1000000
Actor                               510 ns    +470 ns +1198.27 %       x0.08 ±0.19 %    1000000
===============================================================================================
```

Results obtained with Xcode 13.3b1, Swift 5.6, Release build, on MacOS Monterey 12.2

4Ghz Core i7 4790K, late 2014 iMac Retina 5K, 16 GB 1600 MHz DDR3
