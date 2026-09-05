public import Byte
public import Coder
public import Cursor
public import Cursor_Standard_Library_Integration
public import RFC_9293
import Binary_Serializable
import Parser
import Serializer

extension RFC_9293.`3`.`1`.Header {

    public struct Coder<Input: Cursor.`Protocol`<Byte, Never>, Buffer: RangeReplaceableCollection<Byte>>: Coding {

        public typealias Output = RFC_9293.`3`.`1`.Header

        public typealias Failure = RFC_9293.`3`.`1`.Header.Failure

        public init() {}

        public borrowing func parse(_ input: inout Input) throws(Failure) -> Output {
            let start = input.checkpoint

            var fixed: [Byte] = []
            fixed.reserveCapacity(RFC_9293.minimumHeaderSize)
            for _ in 0..<RFC_9293.minimumHeaderSize {
                guard let byte = input.next() else {
                    input.seek(to: start)
                    throw .insufficientBytes
                }
                fixed.append(byte)
            }

            func sixteen(at index: Int) -> UInt16 {
                UInt16(fixed[index].bitPattern) << 8 | UInt16(fixed[index + 1].bitPattern)
            }

            func thirtyTwo(at index: Int) -> UInt32 {
                UInt32(fixed[index].bitPattern) << 24
                    | UInt32(fixed[index + 1].bitPattern) << 16
                    | UInt32(fixed[index + 2].bitPattern) << 8
                    | UInt32(fixed[index + 3].bitPattern)
            }

            let dataOffset: RFC_9293.`3`.`1`.DataOffset
            do throws(RFC_9293.`3`.`1`.DataOffset.Error) {
                dataOffset = try RFC_9293.`3`.`1`.DataOffset(
                    rawValue: fixed[12].bitPattern >> 4
                )
            } catch {
                input.seek(to: start)
                switch error {
                case .valueTooSmall, .notAligned: throw .dataOffsetTooSmall
                case .valueTooLarge: throw .dataOffsetTooLarge
                }
            }

            var options: [Byte] = []
            options.reserveCapacity(dataOffset.optionsLength)
            for _ in 0..<dataOffset.optionsLength {
                guard let byte = input.next() else {
                    input.seek(to: start)
                    throw .insufficientBytes
                }
                options.append(byte)
            }

            return RFC_9293.`3`.`1`.Header(
                sourcePort: RFC_9293.Port(sixteen(at: 0)),
                destinationPort: RFC_9293.Port(sixteen(at: 2)),
                sequenceNumber: RFC_9293.SequenceNumber(rawValue: thirtyTwo(at: 4)),
                acknowledgmentNumber: RFC_9293.SequenceNumber(rawValue: thirtyTwo(at: 8)),
                dataOffset: dataOffset,
                flags: RFC_9293.`3`.`1`.Flags(rawValue: fixed[13].bitPattern),
                window: sixteen(at: 14),
                checksum: sixteen(at: 16),
                urgentPointer: sixteen(at: 18),
                options: options
            )
        }

        public borrowing func serialize(_ output: Output, into buffer: inout Buffer) throws(Failure) {
            RFC_9293.`3`.`1`.Header.serialize(output, into: &buffer)
        }
    }

    public static var coder: Coder<ArraySlice<Byte>, [Byte]> { .init() }
}

extension RFC_9293.`3`.`1`.Header: Coder.Codable {}
