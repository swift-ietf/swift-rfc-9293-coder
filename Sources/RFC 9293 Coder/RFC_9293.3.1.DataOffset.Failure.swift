public import RFC_9293

extension RFC_9293.`3`.`1`.DataOffset {

    public enum Failure: Swift.Error, Sendable, Equatable {

        case insufficientBytes

        case valueTooSmall

        case valueTooLarge
    }
}

extension RFC_9293.`3`.`1`.DataOffset.Failure: CustomStringConvertible {
    public var description: String {
        switch self {
        case .insufficientBytes:
            return "Data offset requires 1 byte"

        case .valueTooSmall:
            return "Data offset must be at least 5 (20 bytes)"

        case .valueTooLarge:
            return "Data offset cannot exceed 15 (60 bytes)"
        }
    }
}
