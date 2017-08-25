//
//  ATAAdjustCommandExecutor.m
//  AdjustTestApp
//
//  Created by Pedro on 23.08.17.
//  Copyright © 2017 adjust. All rights reserved.
//

#import "ATAAdjustCommandExecutor.h"

@implementation ATAAdjustCommandExecutor

- (void)executeCommand:(NSString *)className
            methodName:(NSString *)methodName
            parameters:(NSDictionary *)parameters {

    NSLog(@"executeCommand className: %@, methodName: %@, parameters: %@", className, methodName, parameters);

    if ([methodName isEqualToString:@"factory"]) {

    } else if ([methodName isEqualToString:@"config"]) {
        [self config:parameters];
    } else if ([methodName isEqualToString:@"start"]) {
        [self start:parameters];
    } else if ([methodName isEqualToString:@"event"]) {
        [self event:parameters];
    } else if ([methodName isEqualToString:@"trackEvent"]) {
        [self trackEvent:parameters];
    } else if ([methodName isEqualToString:@"resume"]) {
        [self resume:parameters];
    } else if ([methodName isEqualToString:@"pause"]) {
        [self pause:parameters];
    } else if ([methodName isEqualToString:@"setEnabled"]) {
        [self setEnabled:parameters];
    } else if ([methodName isEqualToString:@"setReferrer"]) {
        [self setReferrer:parameters];
    } else if ([methodName isEqualToString:@"setOfflineMode"]) {
        [self setOfflineMode:parameters];
    } else if ([methodName isEqualToString:@"sendFirstPackages"]) {
        [self sendFirstPackages:parameters];
    } else if ([methodName isEqualToString:@"addSessionCallbackParameter"]) {
        [self addSessionCallbackParameter:parameters];
    } else if ([methodName isEqualToString:@"addSessionPartnerParameter"]) {
        [self addSessionPartnerParameter:parameters];
    } else if ([methodName isEqualToString:@"removeSessionCallbackParameter"]) {
        [self removeSessionCallbackParameter:parameters];
    } else if ([methodName isEqualToString:@"removeSessionPartnerParameter"]) {
        [self removeSessionPartnerParameter:parameters];
    } else if ([methodName isEqualToString:@"resetSessionCallbackParameters"]) {
        [self resetSessionCallbackParameters:parameters];
    } else if ([methodName isEqualToString:@"resetSessionPartnerParameters"]) {
        [self resetSessionPartnerParameters:parameters];
    } else if ([methodName isEqualToString:@"setPushToken"]) {
        [self setPushToken:parameters];
    } else if ([methodName isEqualToString:@"teardown"]) {
        [self teardown:parameters];
    } else if ([methodName isEqualToString:@"openDeeplink"]) {
        [self openDeeplink:parameters];
    } else if ([methodName isEqualToString:@"sendReferrer"]) {
        [self sendReferrer:parameters];
    } else if ([methodName isEqualToString:@"testBegin"]) {
        [self testBegin:parameters];
    } else if ([methodName isEqualToString:@"testEnd"]) {
        [self testEnd:parameters];
    }
}

- (void)config:(NSDictionary *)parameters {

}

- (void)start:(NSDictionary *)parameters {

}

- (void)event:(NSDictionary *)parameters {

}

- (void)trackEvent:(NSDictionary *)parameters {

}

- (void)resume:(NSDictionary *)parameters {

}

- (void)pause:(NSDictionary *)parameters {

}

- (void)setEnabled:(NSDictionary *)parameters {

}

- (void)setReferrer:(NSDictionary *)parameters {

}

- (void)setOfflineMode:(NSDictionary *)parameters {

}

- (void)sendFirstPackages:(NSDictionary *)parameters {

}

- (void)addSessionCallbackParameter:(NSDictionary *)parameters {

}

- (void)addSessionPartnerParameter:(NSDictionary *)parameters {

}

- (void)removeSessionCallbackParameter:(NSDictionary *)parameters {

}

- (void)removeSessionPartnerParameter:(NSDictionary *)parameters {

}

- (void)resetSessionCallbackParameters:(NSDictionary *)parameters {

}

- (void)resetSessionPartnerParameters:(NSDictionary *)parameters {

}

- (void)setPushToken:(NSDictionary *)parameters {

}

- (void)teardown:(NSDictionary *)parameters {

}

- (void)openDeeplink:(NSDictionary *)parameters {

}

- (void)sendReferrer:(NSDictionary *)parameters {

}

- (void)testBegin:(NSDictionary *)parameters {

}

- (void)testEnd:(NSDictionary *)parameters {

}
@end
