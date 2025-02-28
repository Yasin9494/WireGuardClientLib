package com.example.wireguardclientlib;

import android.content.Context;
import com.wireguard.android.backend.GoBackend;
import com.wireguard.android.backend.Tunnel;
import com.wireguard.config.Config;
import com.stealthcopter.networktools.Ping;
import com.stealthcopter.networktools.ping.PingResult;
import com.stealthcopter.networktools.ping.PingStats;

import java.io.ByteArrayInputStream;

public class WireGuardClient implements WireGuardInterface {

    private final GoBackend backend;
    private Tunnel tunnel;
    private WireGuardConnectionStatus currentStatus = WireGuardConnectionStatus.DISCONNECTED;

    public WireGuardClient(Context context) {
        backend = new GoBackend(context);
    }

    @Override
    public void connect(String wgQuickConfig, ConnectionCallback callback) {
        try {
            ByteArrayInputStream inputStream = new ByteArrayInputStream(wgQuickConfig.getBytes());
            Config config = Config.parse(inputStream);

            String tunnelName = "wg0"; // Название туннеля

            tunnel = new Tunnel() {
                @Override
                public String getName() {
                    return tunnelName;
                }

                @Override
                public void onStateChange(State state) {
                    if (state == State.UP) {
                        currentStatus = WireGuardConnectionStatus.CONNECTED;
                    } else {
                        currentStatus = WireGuardConnectionStatus.DISCONNECTED;
                    }
                }
            };

            backend.setState(tunnel, Tunnel.State.UP, config);
            callback.onSuccess();
        } catch (Exception e) {
            currentStatus = WireGuardConnectionStatus.FAILED;
            callback.onFailure(new WireGuardError(e.getMessage()));
        }
    }

    @Override
    public void disconnect(ConnectionCallback callback) {
        try {
            if (tunnel != null) {
                backend.setState(tunnel, Tunnel.State.DOWN, null);
                currentStatus = WireGuardConnectionStatus.DISCONNECTED;
                callback.onSuccess();
            } else {
                callback.onFailure(new WireGuardError("Tunnel is not initialized"));
            }
        } catch (Exception e) {
            currentStatus = WireGuardConnectionStatus.FAILED;
            callback.onFailure(new WireGuardError(e.getMessage()));
        }
    }

    @Override
    public WireGuardConnectionStatus getStatus() {
        return currentStatus;
    }

    @Override
    public WireGuardStats getStats() {
        return new WireGuardStats(0, 0); // Заглушка, позже реализуешь
    }

    @Override
    public void pingServer(String host, PingCallback callback) {
        Ping.onAddress(host)
            .setTimeOutMillis(1000)
            .doPing(new Ping.PingListener() {
                @Override
                public void onResult(PingResult pingResult) {
                    callback.onSuccess(pingResult.getTimeTaken());
                }

                @Override
                public void onFinished(PingStats pingStats) {
                    // Можешь реализовать, если нужно
                }

                @Override
                public void onError(Exception e) {
                    callback.onFailure(new WireGuardError(e.getMessage()));
                }
            });
    }
}
