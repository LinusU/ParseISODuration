import Foundation

fileprivate let weekRegex = try! NSRegularExpression(
    pattern: "^P([0-9]+W)$"
)

fileprivate let dateTimeRegex = try! NSRegularExpression(
    pattern: "^P(([0-9]+Y)?([0-9]+M)?([0-9]+D)?)?(T([0-9]+H)?([0-9]+M)?([0-9]+S)?)?$"
)

fileprivate extension String {
    func substring(with nsrange: NSRange) -> Substring? {
        guard let range = Range(nsrange, in: self) else { return nil }
        return self[range]
    }
}

fileprivate extension Substring {
    func extractInt() -> Int? {
        return Int(self.dropLast())
    }
}

public enum ParseISODurationError: Error {
    case ambiguousDuration
    case invalidDuration
}

public extension TimeInterval {
    init (fromISODuration duration: String) throws {
        let range = NSRange(location: 0, length: duration.utf16.count)

        if let match = weekRegex.firstMatch(in: duration, range: range) {
            let weeks = duration.substring(with: match.range(at: 1))!.extractInt()!

            self = TimeInterval(weeks * 604800000)
            return
        }

        if let match = dateTimeRegex.firstMatch(in: duration, range: range) {
            let year = duration.substring(with: match.range(at: 2))?.extractInt() ?? 0

            guard year == 0 else {
                throw ParseISODurationError.ambiguousDuration
            }

            let month = duration.substring(with: match.range(at: 3))?.extractInt() ?? 0

            guard month == 0 else {
                throw ParseISODurationError.ambiguousDuration
            }

            let days = duration.substring(with: match.range(at: 4))?.extractInt() ?? 0
            let hours = duration.substring(with: match.range(at: 6))?.extractInt() ?? 0
            let minutes = duration.substring(with: match.range(at: 7))?.extractInt() ?? 0
            let seconds = duration.substring(with: match.range(at: 8))?.extractInt() ?? 0

            self = TimeInterval(
                (days * 86400000) +
                (hours * 3600000) +
                (minutes * 60000) +
                (seconds * 1000)
            )
            return
        }

        throw ParseISODurationError.invalidDuration
    }
}
