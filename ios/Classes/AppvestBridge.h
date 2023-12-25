//
//  AppvestBridge.h
//  game_shield
//
//  Created by dx on 2023/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppvestBridge : NSObject

+ (instancetype)sharedInstance;

-(int)init:(NSString*)accessKey  uuid:(NSString*)uuid;
-(int)reinit;
-(int)addListeningPort: (int)port __attribute__((deprecated));
-(int)getLocalPort: (int)port __attribute__((deprecated));
-(int)getHttpLocalPort: (NSString*)host  port:(int)port __attribute__((deprecated));
-(NSString*)getClientIP;
-(NSString*)getProxyServerIP;
-(int)setTimeouts:(int)read_timeout  write_timeout: (int)write_timeout;
- (NSDictionary *)getServerIPAndPort:(nonnull NSString *)host port:(int)port;
-(int)setCredit: (NSString*)uid  credit:(int)credit;

@end

NS_ASSUME_NONNULL_END
