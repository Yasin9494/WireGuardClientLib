package com.example.wireguardclientlib;

public class WireGuardStats {
    public long uploadedBytes;
    public long downloadedBytes;

    public WireGuardStats(long uploadedBytes, long downloadedBytes) {
        this.uploadedBytes = uploadedBytes;
        this.downloadedBytes = downloadedBytes;
    }
}
