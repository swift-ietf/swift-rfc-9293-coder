public import Binary_Serializable
public import Byte
public import RFC_9293

extension RFC_9293.SequenceNumber: @retroactive Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ sequenceNumber: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: sequenceNumber.rawValue >> 24)))
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: sequenceNumber.rawValue >> 16)))
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: sequenceNumber.rawValue >> 8)))
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: sequenceNumber.rawValue)))
    }
}
