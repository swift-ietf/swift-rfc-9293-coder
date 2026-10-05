public import Byte
public import Coder
public import Cursor
public import RFC_9293
import Binary
import Parser
import Serializer

extension RFC_9293.`3`.`1`.Flags {

    public struct Coder<Input: Cursor.`Protocol`<Byte, Never>, Buffer: RangeReplaceableCollection<Byte>>: Coding {
        public var body: Never {
            borrowing get {
                return fatalError("\(Self.self) is a leaf coder: implement parse and serialize directly")
            }
        }


        public typealias Output = RFC_9293.`3`.`1`.Flags

        public typealias Failure = RFC_9293.`3`.`1`.Flags.Error

        public init() {}

        public borrowing func parse(_ input: inout Input) throws(Failure) -> Output {
            guard let byte = input.next() else {
                throw .insufficientBytes
            }
            return RFC_9293.`3`.`1`.Flags(rawValue: byte.bitPattern)
        }

        public borrowing func serialize(_ output: Output, into buffer: inout Buffer) throws(Failure) {
            RFC_9293.`3`.`1`.Flags.serialize(output, into: &buffer)
        }
    }

    public static var coder: Coder<ArraySlice<Byte>, [Byte]> { .init() }
}
