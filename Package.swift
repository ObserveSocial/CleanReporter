import PackageDescription

let package = Package(
    name: "ObserveFocusDefaultReporter",
    dependencies: [
        .Package(url: "/Users/Sam/Projects/Sam/OpenSource/ObserveFocus/Focus/", majorVersion: 0, minor: 4),
        .Package(url: "/Users/Sam/Projects/Sam/OpenSource/ObserveFocus/Observe/",majorVersion: 0 , minor: 3)
    ]
)
