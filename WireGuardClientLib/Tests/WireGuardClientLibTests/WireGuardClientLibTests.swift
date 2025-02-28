import XCTest
@testable import WireGuardClientLib

final class WireGuardClientLibTests: XCTestCase {

    func testWireGuardConfiguration() {
        let config = WireGuardConfiguration(
            interfacePrivateKey: "testKey",
            peerPublicKey: "peerKey",
            peerEndpoint: "example.com:51820",
            allowedIPs: ["0.0.0.0/0"]
        )

        XCTAssertEqual(config.interfacePrivateKey, "testKey")
        XCTAssertEqual(config.peerPublicKey, "peerKey")
        XCTAssertEqual(config.peerEndpoint, "example.com:51820")
        XCTAssertEqual(config.allowedIPs, ["0.0.0.0/0"])
    }

    func testConnectionStatus() {
        let status: WireGuardConnectionStatus = .connected
        if case .connected = status {
            XCTAssertTrue(true)
        } else {
            XCTFail("Статус должен быть .connected")
        }
    }
}
