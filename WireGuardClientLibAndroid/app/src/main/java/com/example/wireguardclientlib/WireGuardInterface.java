package com.example.wireguardclientlib;

public interface WireGuardInterface {
    void connect(WireGuardConfiguration configuration, ConnectionCallback callback);
    void disconnect(ConnectionCallback callback);
    WireGuardConnectionStatus getStatus();
    WireGuardStats getStats();

    interface ConnectionCallback {
        void onSuccess();
        void onFailure(WireGuardError error);
    }
}
void pingServer(String host, PingCallback callback);

interface PingCallback {
    void onSuccess(double latencyMs);
    void onFailure(WireGuardError error);
}
