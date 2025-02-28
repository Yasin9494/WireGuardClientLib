import WireGuard from './index.js';

const config = {
  interfacePrivateKey: '<private-key>',
  peerPublicKey: '<public-key>',
  peerEndpoint: 'server.com:51820',
  allowedIPs: ['0.0.0.0/0'],
  dnsServers: ['8.8.8.8'],
};

WireGuard.connect(config)
  .then(() => {
    console.log('VPN подключен');
    console.log('Статус:', WireGuard.getStatus());
    console.log('Статистика:', WireGuard.getStats());
  })
  .catch((err) => {
    console.log('Ошибка:', err.message);
  });
