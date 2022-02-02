// swift-tools-version: 5.5

import PackageDescription

let package = Package(
  name: "thread-safety-experiments",
  platforms: [.macOS(.v11)],
  products: [
    .executable(
      name: "thread-safety-experiments",
      targets: ["thread-safety-experiments"])
  ],
  dependencies: [
    .package(url: "https://github.com/google/swift-benchmark", .branch("main"))
  ],
  targets: [
    .executableTarget(
      name: "thread-safety-experiments",
      dependencies: [
        .product(name: "Benchmark", package: "swift-benchmark")
      ])
  ]
)
