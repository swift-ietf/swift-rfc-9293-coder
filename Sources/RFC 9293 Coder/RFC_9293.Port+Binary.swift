public import Binary_Serializable
public import Byte
public import RFC_9293

extension RFC_9293.Port: @retroactive Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ port: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: port.rawValue >> 8)))
        buffer.append(Byte(bitPattern: UInt8(truncatingIfNeeded: port.rawValue)))
    }
}
