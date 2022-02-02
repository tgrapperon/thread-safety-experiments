import Benchmark
import Foundation

let suite = BenchmarkSuite(name: "Thread Safety Experiments") { suite in
  Thread.current.threadDictionary["thread-safety-experiments"] = 1

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

  suite.addStudy("Thread Safe Value Access - Get") { study in
    study.benchmarkReference("Direct Access") {
      let _ = value
    }
    study.benchmark("Main Thread Check") {
      if Thread.isMainThread {
        let _ = value
      }
    }
    study.benchmark("Thread.current.threadDictionary") {
      if Thread.current.threadDictionary["thread-safety-experiments"] != nil {
        let _ = value
      }
    }
    study.benchmark("NSRecursiveLock") {
      lock.lock()
      let _ = value
      lock.unlock()
    }
    study.benchmark("@TaskLocal") {
      let _ = TaskLocalHost.value
    }
    study.benchmark("Actor") {
      let _ = Task { await theActor.value }
    }
  }
  suite.addStudy("Thread Safe Value Access - Set") { study in
    study.benchmarkReference("Direct Access") {
      value = 2
    }
    study.benchmark("Main Thread Check") {
      if Thread.isMainThread {
        value = 2
      }
    }
    study.benchmark("Thread.current.threadDictionary") {
      Thread.current.threadDictionary["thread-safety-experiments"] = 2
    }
    study.benchmark("NSRecursiveLock") {
      lock.lock()
      value = 2
      lock.unlock()
    }
    study.benchmark("@TaskLocal") {
      TaskLocalHost.$value.withValue(2) {
        let _ = 2
      }
    }
    study.benchmark("Actor") {
      let _ = Task {
        await theActor.setValue(value: 2)
      }
    }
  }
}

@main
struct Benchmarks {
  static func main() {
    Benchmark.main([
      suite
    ])
  }
}
