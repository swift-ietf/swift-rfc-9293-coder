# swift-rfc-9293-coder

Wire coders for [swift-rfc-9293](https://github.com/swift-ietf/swift-rfc-9293): the TCP port, sequence number, data offset, control flags, option, header and segment each get a `<Type>.Coder` over a byte cursor (the field's network-order octets) and a `Binary.Serializable` conformance; the domain package stays a pure model.
