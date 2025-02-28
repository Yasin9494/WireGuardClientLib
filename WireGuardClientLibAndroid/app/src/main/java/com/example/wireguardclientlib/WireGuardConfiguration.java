package com.example.wireguardclientlib;

import java.util.List;

public class WireGuardConfiguration {
    public String interfacePrivateKey;
    public String peerPublicKey;
    public String peerEndpoint;
    public List<String> allowedIPs;
    public List<String> dnsServers;

    public WireGuardConfiguration(String interfacePrivateKey, String peerPublicKey, String peerEndpoint, List<String> allowedIPs, List<String> dnsServers) {
        this.interfacePrivateKey = interfacePrivateKey;
        this.peerPublicKey = peerPublicKey;
        this.peerEndpoint = peerEndpoint;
        this.allowedIPs = allowedIPs;
        this.dnsServers = dnsServers;
    }
}
