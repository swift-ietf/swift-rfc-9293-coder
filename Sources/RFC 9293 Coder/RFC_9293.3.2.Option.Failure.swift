public import RFC_9293

extension RFC_9293.`3`.`2`.Option {

    public enum Failure: Swift.Error, Sendable, Equatable {

        case insufficientBytes

        case invalidLength
    }
}

extension RFC_9293.`3`.`2`.Option.Failure: CustomStringConvertible {
    public var description: String {
        switch self {
        case .insufficientBytes:
            return "Not enough bytes to read a TCP option"

        case .invalidLength:
            return "Invalid option length"
        }
    }
}
