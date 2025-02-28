import Foundation

public struct WireGuardConfiguration {
    public let interfacePrivateKey: String
    public let peerPublicKey: String
    public let peerEndpoint: String
    public let allowedIPs: [String]
    public let dnsServers: [String]?
    public let keepAliveInterval: TimeInterval?

    public init(interfacePrivateKey: String,
                peerPublicKey: String,
                peerEndpoint: String,
                allowedIPs: [String],
                dnsServers: [String]? = nil,
                keepAliveInterval: TimeInterval? = 25) {
        self.interfacePrivateKey = interfacePrivateKey
        self.peerPublicKey = peerPublicKey
        self.peerEndpoint = peerEndpoint
        self.allowedIPs = allowedIPs
        self.dnsServers = dnsServers
        self.keepAliveInterval = keepAliveInterval
    }
}
