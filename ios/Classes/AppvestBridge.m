//
//  AppvestBridge.m
//  game_shield
//
//  Created by dx on 2023/12/25.
//

#import "AppvestBridge.h"
#import <appvest/appvest.h>

@interface AppvestBridge ()
@property (nonatomic, copy) AppVest* appvest;
@end

@implementation AppvestBridge


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static AppvestBridge *instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (int)getHttpLocalPort:(nonnull NSString *)host port:(int)port {
    return [_appvest getHttpLocalPort:host port:port];
}

- (nonnull NSString *)getProxyServerIP {
    return [_appvest getProxyServerIP];
}

- (NSDictionary *)getServerIPAndPort:(nonnull NSString *)host port:(int)port {
    security_connection_t server;
    int connnn = [_appvest getServerIPAndPort:&server host:host port:port];
    if (connnn != 0) {
        return @{};
    }
    return @{
        @"ip": @(server.ip),
        @"port": @(server.port),
    };
}

- (int)init:(nonnull NSString *)accessKey uuid:(nonnull NSString *)uuid {
    _appvest = [[AppVest alloc] init];
    int res = [_appvest init:accessKey uuid:uuid];
    return res;
}

- (int)reinit {
    return [_appvest reinit];
}

- (int)setCredit:(nonnull NSString *)uid credit:(int)credit {
    return [_appvest setCredit:uid credit:credit];
}

- (int)setTimeouts:(int)read_timeout write_timeout:(int)write_timeout {
    return [_appvest setTimeouts:read_timeout write_timeout:write_timeout];
}

- (nonnull NSString *)getClientIP {
    return [_appvest getClientIP];
}

- (int)addListeningPort:(int)port {
    return [_appvest addListeningPort:port];
}

- (int)getLocalPort:(int)port {
    return [_appvest getLocalPort:port];
}


@end
