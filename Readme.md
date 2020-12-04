# Swift: Parse ISO Duration

Parse an ISO 8601 duration to a `TimeInterval`

## Installation

Install using Swift Package Manager:

```swift
    dependencies: [
        .package(url: "https://github.com/LinusU/ParseISODuration", from: "1.0.0"),
    ]
```

## Usage

```swift
import ParseISODuration

try! TimeInterval(fromISODuration: "PT8S")   // 8 * 1000
try! TimeInterval(fromISODuration: "PT10M")  // 10 * 60 * 1000
try! TimeInterval(fromISODuration: "PT20H")  // 20 * 60 * 60 * 1000
try! TimeInterval(fromISODuration: "PT6M4S") // 6 * 60 * 1000 + 4 * 1000

try! TimeInterval(fromISODuration: "P10Y10M10D")  // Throws ParseISODurationError.ambiguousDuration
try! TimeInterval(fromISODuration: "Hello world") // Throws ParseISODurationError.invalidDuration
```

## Year and month

If years or months is specified and more than 0 the library will throw `ParseISODurationError.ambiguousDuration` since it's meaning can't be converted to milliseconds.

## Related

- Node.js version: [LinusU/node-parse-iso-duration](https://github.com/LinusU/node-parse-iso-duration)

## License

MIT
