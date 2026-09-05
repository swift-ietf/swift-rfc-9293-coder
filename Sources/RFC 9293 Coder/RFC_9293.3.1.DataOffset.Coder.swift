public import Byte
public import Coder
public import Cursor
public import Cursor_Standard_Library_Integration
public import RFC_9293
import Binary_Serializable
import Parser
import Serializer

extension RFC_9293.`3`.`1`.DataOffset {

    public struct Coder<Input: Cursor.`Protocol`<Byte, Never>, Buffer: RangeReplaceableCollection<Byte>>: Coding {

        public typealias Output = RFC_9293.`3`.`1`.DataOffset

        public typealias Failure = RFC_9293.`3`.`1`.DataOffset.Failure

        public init() {}

        public borrowing func parse(_ input: inout Input) throws(Failure) -> Output {
            let start = input.checkpoint
            guard let byte = input.next() else {
                throw .insufficientBytes
            }
            do throws(RFC_9293.`3`.`1`.DataOffset.Error) {
                return try RFC_9293.`3`.`1`.DataOffset(rawValue: byte.bitPattern >> 4)
            } catch {
                input.seek(to: start)
                switch error {
                case .valueTooSmall, .notAligned: throw .valueTooSmall
                case .valueTooLarge: throw .valueTooLarge
                }
            }
        }

        public borrowing func serialize(_ output: Output, into buffer: inout Buffer) throws(Failure) {
            RFC_9293.`3`.`1`.DataOffset.serialize(output, into: &buffer)
        }
    }

    public static var coder: Coder<ArraySlice<Byte>, [Byte]> { .init() }
}

extension RFC_9293.`3`.`1`.DataOffset: Coder.Codable {}
