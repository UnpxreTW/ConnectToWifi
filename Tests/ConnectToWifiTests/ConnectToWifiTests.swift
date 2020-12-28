import XCTest
@testable import ConnectToWifi

final class ConnectToWifiTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ConnectToWifi().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
