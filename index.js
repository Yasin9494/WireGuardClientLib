import { NativeModules } from 'react-native';

const { WireGuardClientLib } = NativeModules;

export default {
  connect: (wgQuickConfig) => {
    return new Promise((resolve, reject) => {
      WireGuardClientLib.connect(wgQuickConfig, (success, error) => {
        if (success) resolve();
        else reject(new Error(error));
      });
    });
  },

  disconnect: () => {
    return new Promise((resolve, reject) => {
      WireGuardClientLib.disconnect((success, error) => {
        if (success) resolve();
        else reject(new Error(error));
      });
    });
  },

  status: () => WireGuardClientLib.getStatus(),

  stats: () => WireGuardClientLib.getStats(),

  ping: (host) => {
    return new Promise((resolve, reject) => {
      WireGuardClientLib.pingServer(host, (latencyMs, error) => {
        if (error) reject(new Error(error));
        else resolve(latencyMs);
      });
    });
  },
};
