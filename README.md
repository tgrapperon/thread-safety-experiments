# thread-safety-experiments

An experimentation of various strategies for thread-safe access to some global value, using [swift-benchmark](https://github.com/google/swift-benchmark)

```
name                                                           time       std        iterations
-----------------------------------------------------------------------------------------------
Thread Safe Value Access - Get.Direct Access                    25.000 ns ± 319.11 %    1000000
Thread Safe Value Access - Get.Main Thread Check                32.000 ns ± 374.82 %    1000000
Thread Safe Value Access - Get.Thread.current.threadDictionary 383.000 ns ±  99.03 %    1000000
Thread Safe Value Access - Get.NSRecursiveLock                  61.000 ns ± 186.22 %    1000000
Thread Safe Value Access - Get.@TaskLocal                       42.000 ns ± 283.91 %    1000000
Thread Safe Value Access - Get.Actor                           217.000 ns ± 691.59 %    1000000

Thread Safe Value Access - Set.Direct Access                    26.000 ns ± 436.62 %    1000000
Thread Safe Value Access - Set.Main Thread Check                31.000 ns ± 794.86 %    1000000
Thread Safe Value Access - Set.Thread.current.threadDictionary 412.000 ns ± 233.52 %    1000000
Thread Safe Value Access - Set.NSRecursiveLock                  64.000 ns ± 395.22 %    1000000
Thread Safe Value Access - Set.@TaskLocal                      214.000 ns ±  83.85 %    1000000
Thread Safe Value Access - Set.Actor                           195.000 ns ± 410.73 %    1000000
```

Results obtained with Xcode 13.3b1, Swift 5.6, Release build, on MacOS Monterey 12.2

4Ghz Core i7 4790K, late 2014 iMac Retina 5K, 16 GB 1600 MHz DDR3
