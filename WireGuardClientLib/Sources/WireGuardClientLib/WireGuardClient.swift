import Foundation
import WireGuardKit

public class WireGuardClient: WireGuardInterface {
    private let tunnelProvider = NETunnelProviderManager()

    public init() {}

    public func connect(configuration: WireGuardConfiguration, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }

    public func disconnect(completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }

    public func connectionStatus() -> WireGuardConnectionStatus {
        return .disconnected
    }

    public func trafficStats() -> WireGuardStats {
        return WireGuardStats(uploadedBytes: 0, downloadedBytes: 0)
    }

    public func pingServer(completion: @escaping (Result<TimeInterval, Error>) -> Void) {
        completion(.success(0.2))
    }
}
