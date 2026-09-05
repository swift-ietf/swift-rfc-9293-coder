public import RFC_9293

extension RFC_9293.`3`.`1`.Flags {

    public enum Failure: Swift.Error, Sendable, Equatable {

        case insufficientBytes
    }
}

extension RFC_9293.`3`.`1`.Flags.Failure: CustomStringConvertible {
    public var description: String {
        switch self {
        case .insufficientBytes:
            return "Control flags require 1 byte"
        }
    }
}
