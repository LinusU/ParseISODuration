import XCTest
import ParseISODuration

final class ParseISODurationTests: XCTestCase {
    func testAmbiguous() {
        XCTAssertThrowsError(try TimeInterval(fromISODuration: "P10Y")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.ambiguousDuration) }
        XCTAssertThrowsError(try TimeInterval(fromISODuration: "P5MT10M")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.ambiguousDuration) }
        XCTAssertThrowsError(try TimeInterval(fromISODuration: "P0Y1M")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.ambiguousDuration) }
        XCTAssertThrowsError(try TimeInterval(fromISODuration: "P1Y0MT24H")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.ambiguousDuration) }
        XCTAssertThrowsError(try TimeInterval(fromISODuration: "P8Y20M10D")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.ambiguousDuration) }
    }

    func testDateTime() {
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT0S"), TimeInterval(0))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT1S"), TimeInterval(1 * 1000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT5S"), TimeInterval(5 * 1000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT10S"), TimeInterval(10 * 1000))

        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT0M"), TimeInterval(0))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT1M"), TimeInterval(1 * 60000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT5M"), TimeInterval(5 * 60000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT10M"), TimeInterval(10 * 60000))

        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT0H"), TimeInterval(0))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT1H"), TimeInterval(1 * 3600000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT5H"), TimeInterval(5 * 3600000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT10H"), TimeInterval(10 * 3600000))

        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT0H2M"), TimeInterval(2 * 60000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT1H5M"), TimeInterval(1 * 3600000 + 5 * 60000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT5H10S"), TimeInterval(5 * 3600000 + 10 * 1000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "PT10H40M23S"), TimeInterval(10 * 3600000 + 40 * 60000 + 23 * 1000))

        XCTAssertEqual(try! TimeInterval(fromISODuration: "P0D"), TimeInterval(0 * 86400000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P1D"), TimeInterval(1 * 86400000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P5D"), TimeInterval(5 * 86400000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P10D"), TimeInterval(10 * 86400000))

        XCTAssertEqual(try! TimeInterval(fromISODuration: "P0DT30M"), TimeInterval(0 * 86400000 + 30 * 60000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P10DT30S"), TimeInterval(10 * 86400000 + 30 * 1000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P12DT28M"), TimeInterval(12 * 86400000 + 28 * 60000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P14DT26H"), TimeInterval(14 * 86400000 + 26 * 3600000))
    }

    func testInvalid() {
        XCTAssertThrowsError(try TimeInterval(fromISODuration: "Jsjd kals")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.invalidDuration) }
        XCTAssertThrowsError(try TimeInterval(fromISODuration: "PTJKS")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.invalidDuration) }
        XCTAssertThrowsError(try TimeInterval(fromISODuration: "PT123123")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.invalidDuration) }
        XCTAssertThrowsError(try TimeInterval(fromISODuration: " gdjfkds")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.invalidDuration) }
        XCTAssertThrowsError(try TimeInterval(fromISODuration: "Hello, World!")) { XCTAssertEqual($0 as? ParseISODurationError, ParseISODurationError.invalidDuration) }
    }

    func testWeek() {
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P0W"), TimeInterval(0))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P1W"), TimeInterval(1 * 604800000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P5W"), TimeInterval(5 * 604800000))
        XCTAssertEqual(try! TimeInterval(fromISODuration: "P10W"), TimeInterval(10 * 604800000))
    }

    static var allTests = [
        ("testAmbiguous", testAmbiguous),
        ("testDateTime", testDateTime),
        ("testInvalid", testInvalid),
        ("testWeek", testWeek),
    ]
}
