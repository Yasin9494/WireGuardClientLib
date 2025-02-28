#import "WireGuardNativeAdapter.h"
#import <WireGuardKit/WireGuardKit.h>

@interface WireGuardNativeAdapter ()
@property (nonatomic, strong) NETunnelProviderManager *providerManager;
@end

@implementation WireGuardNativeAdapter

- (instancetype)init {
    if (self = [super init]) {
        [self loadProviderManager];
    }
    return self;
}

- (void)loadProviderManager {
    [NETunnelProviderManager loadAllFromPreferencesWithCompletionHandler:^(NSArray<NETunnelProviderManager *> *managers, NSError *error) {
        if (managers.count > 0) {
            self.providerManager = managers.firstObject;
        } else {
            self.providerManager = [[NETunnelProviderManager alloc] init];
        }
    }];
}

- (void)connectWithConfig:(NSDictionary *)config completion:(void (^)(BOOL success, NSString *error))completion {
    NSString *privateKey = config[@"interfacePrivateKey"];
    NSString *peerPublicKey = config[@"peerPublicKey"];
    NSString *peerEndpoint = config[@"peerEndpoint"];
    NSArray *allowedIPs = config[@"allowedIPs"];
    NSArray *dnsServers = config[@"dnsServers"];

    if (!privateKey || !peerPublicKey || !peerEndpoint || !allowedIPs) {
        completion(NO, @"Invalid configuration parameters");
        return;
    }

    NSString *interfaceConfig = [NSString stringWithFormat:@"[Interface]\nPrivateKey = %@\nAddress = 10.0.0.2/32\nDNS = %@\n\n[Peer]\nPublicKey = %@\nAllowedIPs = %@\nEndpoint = %@",
                                 privateKey,
                                 [dnsServers componentsJoinedByString:@", "] ?: @"8.8.8.8",
                                 peerPublicKey,
                                 [allowedIPs componentsJoinedByString:@", "],
                                 peerEndpoint];

    NETunnelProviderProtocol *protocol = [[NETunnelProviderProtocol alloc] init];
    protocol.providerBundleIdentifier = @"com.wireguard.ios.network-extension";
    protocol.providerConfiguration = @{@"WgQuickConfig": interfaceConfig};
    protocol.serverAddress = peerEndpoint;

    self.providerManager.protocolConfiguration = protocol;
    self.providerManager.localizedDescription = @"WireGuard VPN";
    self.providerManager.enabled = YES;

    [self.providerManager saveToPreferencesWithCompletionHandler:^(NSError *error) {
        if (error) {
            completion(NO, error.localizedDescription);
            return;
        }

        [self.providerManager loadFromPreferencesWithCompletionHandler:^(NSError *loadError) {
            if (loadError) {
                completion(NO, loadError.localizedDescription);
                return;
            }

            NSError *startError = nil;
            [self.providerManager.connection startVPNTunnelWithOptions:nil andReturnError:&startError];

            if (startError) {
                completion(NO, startError.localizedDescription);
            } else {
                completion(YES, nil);
            }
        }];
    }];
}

- (void)disconnectWithCompletion:(void (^)(BOOL success, NSString *error))completion {
    if (self.providerManager.connection.status == NEVPNStatusDisconnected) {
        completion(YES, @"Already disconnected");
        return;
    }

    [self.providerManager.connection stopVPNTunnel];
    completion(YES, nil);
}

@end
