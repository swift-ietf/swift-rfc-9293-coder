import Byte
import Coder
import Coder_Standard_Library_Integration
import Cursor_Standard_Library_Integration
import Parser
import RFC_9293
import RFC_9293_Coder
import Serializer
import Testing

@Suite
struct `RFC_9293.3.1.DataOffset.Coder Tests` {

    @Test
    func `reads the data offset from the high nibble of one octet`() throws {
        var input = bytes(0x50)[...]
        let offset = try RFC_9293.`3`.`1`.DataOffset.coder.parse(&input)

        #expect(offset == .minimum)
        #expect(input.isEmpty)
    }

    @Test
    func `writes the data offset into the high nibble of one octet`() throws {
        #expect(try RFC_9293.`3`.`1`.DataOffset.maximum.encoded() == bytes(0xF0))
    }

    @Test
    func `rejects a data offset below five and restores the cursor`() {
        var input = bytes(0x40)[...]
        #expect(throws: RFC_9293.`3`.`1`.DataOffset.Failure.valueTooSmall) {
            try RFC_9293.`3`.`1`.DataOffset.coder.parse(&input)
        }
        #expect(input.count == 1)
    }

    @Test
    func `rejects empty input`() {
        var input = bytes()[...]
        #expect(throws: RFC_9293.`3`.`1`.DataOffset.Failure.insufficientBytes) {
            try RFC_9293.`3`.`1`.DataOffset.coder.parse(&input)
        }
    }
}
