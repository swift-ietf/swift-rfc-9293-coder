public import RFC_9293

extension RFC_9293.Segment {

    public enum Failure: Swift.Error, Sendable, Equatable {

        case insufficientBytes

        case invalidDataOffset
    }
}

extension RFC_9293.Segment.Failure: CustomStringConvertible {
    public var description: String {
        switch self {
        case .insufficientBytes:
            return "Not enough bytes to read a TCP segment"

        case .invalidDataOffset:
            return "Invalid data offset in the TCP header"
        }
    }
}
