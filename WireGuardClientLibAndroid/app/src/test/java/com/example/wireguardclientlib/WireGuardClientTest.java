package com.example.wireguardclientlib;

import org.junit.Test;
import java.util.Arrays;

import static org.junit.Assert.*;

public class WireGuardClientTest {

    @Test
    public void testWireGuardConfiguration() {
        WireGuardConfiguration config = new WireGuardConfiguration(
                "privateKey", "publicKey", "example.com:51820",
                Arrays.asList("0.0.0.0/0"), Arrays.asList("8.8.8.8")
        );

        assertEquals("privateKey", config.interfacePrivateKey);
        assertEquals("publicKey", config.peerPublicKey);
        assertEquals("example.com:51820", config.peerEndpoint);
    }
}
