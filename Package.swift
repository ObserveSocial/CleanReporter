import PackageDescription

let package = Package(
    name: "CleanReporter",
    dependencies: [
        .Package(url: "https://github.com/ObserveSocial/Focus.git", majorVersion: 0, minor: 4),
        .Package(url: "https://github.com/ObserveSocial/Observe.git",majorVersion: 0 , minor: 3)
    ]
)
