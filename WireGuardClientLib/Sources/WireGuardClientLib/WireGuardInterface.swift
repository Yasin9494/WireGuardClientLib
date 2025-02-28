import Foundation

public protocol WireGuardInterface {
    func connect(wgQuickConfig: String, completion: @escaping (Result<Void, Error>) -> Void)
    func disconnect(completion: @escaping (Result<Void, Error>) -> Void)
    func connectionStatus() -> WireGuardConnectionStatus
    func trafficStats() -> WireGuardStats
    func pingServer(completion: @escaping (Result<TimeInterval, Error>) -> Void)
}
