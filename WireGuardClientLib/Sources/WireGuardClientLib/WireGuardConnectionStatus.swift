import Foundation

public enum WireGuardConnectionStatus {
    case connected
    case disconnected
    case connecting
    case disconnecting
    case failed(WireGuardError)
}
