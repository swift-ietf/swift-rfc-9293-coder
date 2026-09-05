public import RFC_9293

extension RFC_9293.Port {

    public enum Failure: Swift.Error, Sendable, Equatable {

        case empty

        case insufficientBytes
    }
}

extension RFC_9293.Port.Failure: CustomStringConvertible {
    public var description: String {
        switch self {
        case .empty:
            return "Port bytes cannot be empty"

        case .insufficientBytes:
            return "Port requires 2 bytes"
        }
    }
}
