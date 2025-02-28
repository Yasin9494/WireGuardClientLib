import { NativeModules, Platform } from 'react-native';

const { WireGuardClientLib } = NativeModules;

const WireGuard = {
  connect: (config) => {
    return new Promise((resolve, reject) => {
      WireGuardClientLib.connect(config, (success, error) => {
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

  ping: (host) => {
    return new Promise((resolve, reject) => {
      WireGuardClientLib.pingServer(host, (latencyMs, error) => {
        if (error) reject(new Error(error));
        else resolve(latencyMs);
      });
    });
  },  

  getStatus: () => WireGuardClientLib.getStatus(),

  getStats: () => WireGuardClientLib.getStats(),

  ping: () => WireGuardClientLib.pingServer(),
};



export default WireGuard;
