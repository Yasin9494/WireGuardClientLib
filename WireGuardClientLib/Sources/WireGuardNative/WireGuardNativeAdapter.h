#import <Foundation/Foundation.h>

@interface WireGuardNativeAdapter : NSObject

- (void)connectWithConfig:(NSDictionary *)config completion:(void (^)(BOOL success, NSString *error))completion;
- (void)disconnectWithCompletion:(void (^)(BOOL success, NSString *error))completion;

@end
