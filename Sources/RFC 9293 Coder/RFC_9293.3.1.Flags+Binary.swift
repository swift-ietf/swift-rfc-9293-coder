public import Binary_Serializable
public import Byte
public import RFC_9293

extension RFC_9293.`3`.`1`.Flags: @retroactive Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ flags: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(Byte(bitPattern: flags.rawValue))
    }
}
