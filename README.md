# thread-safety-experiments

An experimentation of various strategies for thread-safe access to some global value, using [swift-measure](https://github.com/tgrapperon/swift-measure)

```
== Thread Safety Experiments ==================================================================
                                    Value  Difference Variation  Performance  Error  Iterations
-- Thread Safe Value Access - Get -------------------------------------------------------------
Direct Access                   (*)  29 ns                                   ±0.40 %    1000000
Main Thread Check                    33 ns      +4 ns   +12.25 %       x0.89 ±0.28 %    1000000
Thread.current.threadDictionary     423 ns    +394 ns +1339.71 %       x0.07 ±0.10 %    1000000
NSRecursiveLock                      69 ns     +39 ns  +133.29 %       x0.43 ±0.18 %    1000000
@TaskLocal                           46 ns     +16 ns   +56.05 %       x0.64 ±0.24 %    1000000
Actor                               477 ns    +447 ns +1522.07 %       x0.06 ±0.23 %    1000000
-- Thread Safe Value Access - Set -------------------------------------------------------------
Direct Access                   (*)  33 ns                                   ±0.56 %    1000000
Main Thread Check                    37 ns      +4 ns   +10.73 %       x0.90 ±0.46 %    1000000
Thread.current.threadDictionary     440 ns    +407 ns +1220.99 %       x0.08 ±0.08 %    1000000
NSRecursiveLock                      68 ns     +35 ns  +104.85 %       x0.49 ±0.18 %    1000000
@TaskLocal                          255 ns    +222 ns  +666.14 %       x0.13 ±0.12 %    1000000
Actor                               424 ns    +391 ns +1172.30 %       x0.08 ±0.20 %    1000000
===============================================================================================
```

Results obtained with Xcode 13.3b1, Swift 5.6, Release build, on MacOS Monterey 12.2

4Ghz Core i7 4790K, late 2014 iMac Retina 5K, 16 GB 1600 MHz DDR3
