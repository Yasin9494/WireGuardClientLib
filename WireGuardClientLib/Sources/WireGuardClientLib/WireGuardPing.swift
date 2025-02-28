import Foundation
import Network

class WireGuardPing {
    static func ping(host: String, completion: @escaping (Result<TimeInterval, Error>) -> Void) {
        let startTime = Date()
        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                let latency = Date().timeIntervalSince(startTime)
                completion(.success(latency))
            } else {
                completion(.failure(WireGuardError.pingFailed))
            }
            monitor.cancel()
        }

        let queue = DispatchQueue(label: "PingQueue")
        monitor.start(queue: queue)
    }
}
