// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "CleanReporter",
  products: [
    .library(
      name: "CleanReporter",
      targets: ["CleanReporter"]),
    ],
  dependencies: [
    .package(url: "https://github.com/meech-ward/Observe", from: "0.5.1"),
    .package(url: "https://github.com/meech-ward/Focus", from: "0.6.2")
  ],
  targets: [
    .target(
      name: "CleanReporter",
      dependencies: ["Observe", "Focus"],
      path: "Sources"
    ),
    .testTarget(
      name: "ObserveFocusDefaultReporterTests",
      dependencies: ["CleanReporter", "Observe", "Focus"]
    )
  ]
)

