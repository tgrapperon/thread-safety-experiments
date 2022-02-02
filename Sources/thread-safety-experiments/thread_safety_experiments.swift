import Benchmark
import Foundation

var value: Int = 0

let lock = NSRecursiveLock()

struct TaskLocalHost {
  @TaskLocal static var value: Int = 0
}

actor Actor {
  init() {}
  var value: Int = 0
  func setValue(value: Int) async {
    self.value = value
    return ()
  }
}

let theActor = Actor()

let suiteGet = BenchmarkSuite(name: "Thread Safe Value Access - Get") { suite in
  Thread.current.threadDictionary["thread-safety-experiments"] = 1

  //  suite.addStudy("Thread Safe Value Access - Get") { study in
  suite.benchmark("Direct Access") {
    let _ = value
  }
  suite.benchmark("Main Thread Check") {
    if Thread.isMainThread {
      let _ = value
    }
  }
  suite.benchmark("Thread.current.threadDictionary") {
    if Thread.current.threadDictionary["thread-safety-experiments"] != nil {
      let _ = value
    }
  }
  suite.benchmark("NSRecursiveLock") {
    lock.lock()
    let _ = value
    lock.unlock()
  }
  suite.benchmark("@TaskLocal") {
    let _ = TaskLocalHost.value
  }
  suite.benchmark("Actor") {
    let _ = Task { await theActor.value }
  }
}

let suiteSet = BenchmarkSuite(name: "Thread Safe Value Access - Set") { suite in
  suite.benchmark("Direct Access") {
    value = 2
  }
  suite.benchmark("Main Thread Check") {
    if Thread.isMainThread {
      value = 2
    }
  }
  suite.benchmark("Thread.current.threadDictionary") {
    Thread.current.threadDictionary["thread-safety-experiments"] = 2
  }
  suite.benchmark("NSRecursiveLock") {
    lock.lock()
    value = 2
    lock.unlock()
  }
  suite.benchmark("@TaskLocal") {
    TaskLocalHost.$value.withValue(2) {
      let _ = 2
    }
  }
  suite.benchmark("Actor") {
    let _ = Task {
      await theActor.setValue(value: 2)
    }
  }
}

@main
struct Benchmarks {
  static func main() {
    Benchmark.main([
      suiteGet,
      suiteSet,
    ])
  }
}
