public import Binary
public import Byte
public import RFC_9293

extension RFC_9293.`3`.`1`.DataOffset: @retroactive Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ offset: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(Byte(bitPattern: offset.rawValue << 4))
    }
}
