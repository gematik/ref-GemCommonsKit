import XCTest
@testable import GemCommonsKit

final class GemCommonsKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GemCommonsKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
