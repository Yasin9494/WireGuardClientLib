import Foundation
import NetworkExtension

public class WireGuardClient: WireGuardInterface {
    private let providerManager = NETunnelProviderManager()

    public init() {}

    public func connect(wgQuickConfig: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let protocolConfig = NETunnelProviderProtocol()
        protocolConfig.providerBundleIdentifier = "com.wireguard.ios.network-extension"
        protocolConfig.providerConfiguration = ["WgQuickConfig": wgQuickConfig]
        protocolConfig.serverAddress = "WireGuard"

        providerManager.protocolConfiguration = protocolConfig
        providerManager.localizedDescription = "WireGuard VPN"
        providerManager.enabled = true

        providerManager.saveToPreferences { error in
            if let error = error {
                completion(.failure(error))
                return
            }

            self.providerManager.loadFromPreferences { loadError in
                if let loadError = loadError {
                    completion(.failure(loadError))
                    return
                }

                do {
                    try self.providerManager.connection.startVPNTunnel()
                    completion(.success(()))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    public func disconnect(completion: @escaping (Result<Void, Error>) -> Void) {
        providerManager.connection.stopVPNTunnel()
        completion(.success(()))
    }

    public func connectionStatus() -> WireGuardConnectionStatus {
        switch providerManager.connection.status {
        case .connected:
            return .connected
        case .connecting:
            return .connecting
        case .disconnected:
            return .disconnected
        case .disconnecting:
            return .disconnecting
        default:
            return .failed(.unknown("Unknown status"))
        }
    }

    public func trafficStats() -> WireGuardStats {      
        return WireGuardStats(uploadedBytes: 0, downloadedBytes: 0)
    }

    public func pingServer(completion: @escaping (Result<TimeInterval, Error>) -> Void) {
        completion(.success(0.2))
    }
}
