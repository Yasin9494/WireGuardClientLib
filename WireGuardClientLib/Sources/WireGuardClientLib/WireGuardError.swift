import Foundation

public enum WireGuardError: Error {
    case invalidConfiguration
    case connectionFailed(String)
    case disconnectionFailed(String)
    case pingFailed
    case unknown(String)

    public var localizedDescription: String {
        switch self {
        case .invalidConfiguration:
            return "Неверная конфигурация."
        case .connectionFailed(let reason):
            return "Ошибка подключения: \(reason)"
        case .disconnectionFailed(let reason):
            return "Ошибка отключения: \(reason)"
        case .pingFailed:
            return "Ошибка пинга сервера."
        case .unknown(let reason):
            return "Неизвестная ошибка: \(reason)"
        }
    }
}
