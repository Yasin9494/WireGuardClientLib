package com.example.wireguardclientlib;

public interface WireGuardInterface {
    void connect(String wgQuickConfig, ConnectionCallback callback);
    void disconnect(ConnectionCallback callback);
    WireGuardConnectionStatus getStatus();
    WireGuardStats getStats();
    void pingServer(String host, PingCallback callback);

    interface ConnectionCallback {
        void onSuccess();
        void onFailure(WireGuardError error);
    }

    interface PingCallback {
        void onSuccess(double latencyMs);
        void onFailure(WireGuardError error);
    }
}
