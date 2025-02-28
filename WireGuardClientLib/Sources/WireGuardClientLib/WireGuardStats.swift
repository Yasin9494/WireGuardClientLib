import Foundation

public struct WireGuardStats {
    public let uploadedBytes: UInt64
    public let downloadedBytes: UInt64

    public init(uploadedBytes: UInt64, downloadedBytes: UInt64) {
        self.uploadedBytes = uploadedBytes
        self.downloadedBytes = downloadedBytes
    }
}
