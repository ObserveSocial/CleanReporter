import XCTest
@testable import ObserveFocusDefaultReporter

class ObserveFocusDefaultReporterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ObserveFocusDefaultReporter().text, "Hello, World!")
    }


    static var allTests : [(String, (ObserveFocusDefaultReporterTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
