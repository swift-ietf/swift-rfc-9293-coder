public import RFC_9293

extension RFC_9293.`3`.`1`.Header {

    public enum Failure: Swift.Error, Sendable, Equatable {

        case insufficientBytes

        case dataOffsetTooSmall

        case dataOffsetTooLarge
    }
}

extension RFC_9293.`3`.`1`.Header.Failure: CustomStringConvertible {
    public var description: String {
        switch self {
        case .insufficientBytes:
            return "TCP header requires at least 20 bytes"

        case .dataOffsetTooSmall:
            return "Data offset must be at least 5 (20 bytes)"

        case .dataOffsetTooLarge:
            return "Data offset cannot exceed 15 (60 bytes)"
        }
    }
}
