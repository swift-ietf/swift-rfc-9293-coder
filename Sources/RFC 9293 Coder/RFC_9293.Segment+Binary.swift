public import Binary_Serializable
public import Byte
public import RFC_9293

extension RFC_9293.Segment: @retroactive Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ segment: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        RFC_9293.`3`.`1`.Header.serialize(segment.header, into: &buffer)
        buffer.append(contentsOf: segment.data)
    }
}
