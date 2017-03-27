# Observe & Focus Clean Reporter

[Observe](https://github.com/ObserveSocial/Observe) is a BDD / TDD test framework for Swift 3 that pairs very nicely with the [Focus](https://github.com/ObserveSocial/Focus) assertion framework.

Use this reporter to nicely print the test ouput from these frameworks.

## Requirements

 * Swift 3.0+

## How To Use

### Installing

Open your `Package.Swift` file and add the following depedency:

```swift
import PackageDescription

let package = Package(
    name: "Hello",
    dependencies: [
        .Package(url: "https://github.com/ObserveSocial/Observe.git", majorVersion: 0),
        .Package(url: "https://github.com/ObserveSocial/Focus.git", majorVersion: 0),
        .Package(url: "https://github.com/ObserveSocial/CleanReporter.git", majorVersion: 0, minor: 1)
    ]
)
```

Run `swift build` in terminal to fetch this new dependency.

### Running Tests With XCTest

```swift
class CleanReporterTests: XCTestCase {

    override class func setUp() {
        let reporter = Reporter.sharedInstance
        reporter.failBlock = XCTFail
        Focus.set(reporter: reporter)
        Observe.set(reporter: reporter)
    }
    
    func testSpec() {
        describe("Person") {
            
            context("Initialize a new Person") {
                var person: Person!
                
                beforeEach {
                    person(name: "Sam")
                }
                
                it("should be called sam") {
                    expect(person.name == "Sam").to.be.true("The person's name is not sam")
                }
            }
        }
    }
}
```

## Running the Tests

The output from this reporter doesn't look great in Xcode's console. For best results, use terminal when running your tests. Use the following command for the best results:

```bash
$ swift test | awk '!/Test Case/ && !/Test Suite/'
```

## Contributing

All developers should feel welcome and encouraged to contribute to Observe, see our [CONTRIBUTING](https://github.com/ObserveSocial/CleanReporter/CONTRIBUTING.md) document here to get involved.