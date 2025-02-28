package com.example.wireguardclientlib;

import android.content.Context;
import com.wireguard.android.backend.GoBackend;
import com.wireguard.android.backend.Tunnel;
import com.wireguard.config.Config;
import com.stealthcopter.networktools.Ping;

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
            Config config = Config.parse(wgQuickConfig);
            tunnel = backend.create("wg-tunnel", config, Tunnel.State.UP, null);
            currentStatus = WireGuardConnectionStatus.CONNECTED;
            callback.onSuccess();
        } catch (Exception e) {
            currentStatus = WireGuardConnectionStatus.FAILED;
            callback.onFailure(new WireGuardError(e.getMessage()));
        }
    }

    @Override
    public void disconnect(ConnectionCallback callback) {
        try {
            backend.setState(tunnel, Tunnel.State.DOWN, null);
            currentStatus = WireGuardConnectionStatus.DISCONNECTED;
            callback.onSuccess();
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
        if (tunnel != null) {
            Tunnel.Statistics stats = backend.getStatistics(tunnel);
            return new WireGuardStats(stats.totalTx(), stats.totalRx());
        }
        return new WireGuardStats(0,0);
    }

    @Override
    public void pingServer(String host, PingCallback callback) {
        Ping.onAddress(host).setTimeOutMillis(1000).doPing(new Ping.PingListener() {
            @Override
            public void onResult(Ping.PingResult pingResult) {
                callback.onSuccess(pingResult.getTimeTaken());
            }

            @Override
            public void onFinished() {}

            @Override
            public void onError(Exception e) {
                callback.onFailure(new WireGuardError(e.getMessage()));
            }
        });
    }
}
