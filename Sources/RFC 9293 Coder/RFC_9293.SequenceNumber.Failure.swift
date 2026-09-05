public import RFC_9293

extension RFC_9293.SequenceNumber {

    public enum Failure: Swift.Error, Sendable, Equatable {

        case insufficientBytes
    }
}

extension RFC_9293.SequenceNumber.Failure: CustomStringConvertible {
    public var description: String {
        switch self {
        case .insufficientBytes:
            return "Sequence number requires 4 bytes"
        }
    }
}
