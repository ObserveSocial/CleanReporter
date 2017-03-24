import PackageDescription

let package = Package(
    name: "ObserveFocusDefaultReporter",
    dependencies: [
        .Package(url: "/Users/Sam/Projects/Sam/OpenSource/ObserveFocus/Focus/", majorVersion: 0),
        .Package(url: "/Users/Sam/Projects/Sam/OpenSource/ObserveFocus/Observe/", majorVersion: 0)
    ]
)
