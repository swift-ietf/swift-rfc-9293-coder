public import Binary_Serializable
public import Byte
public import RFC_9293

extension RFC_9293.`3`.`1`.Header: @retroactive Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ header: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        RFC_9293.Port.serialize(header.sourcePort, into: &buffer)
        RFC_9293.Port.serialize(header.destinationPort, into: &buffer)
        RFC_9293.SequenceNumber.serialize(header.sequenceNumber, into: &buffer)
        RFC_9293.SequenceNumber.serialize(header.acknowledgmentNumber, into: &buffer)
        RFC_9293.`3`.`1`.DataOffset.serialize(header.dataOffset, into: &buffer)
        RFC_9293.`3`.`1`.Flags.serialize(header.flags, into: &buffer)
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: header.window >> 8)))
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: header.window)))
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: header.checksum >> 8)))
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: header.checksum)))
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: header.urgentPointer >> 8)))
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: header.urgentPointer)))
        buffer.append(contentsOf: header.options)
    }
}
