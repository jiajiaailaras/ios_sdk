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
}

- (void)executeCommand:(NSString *)className
            methodName:(NSString *)methodName
        jsonParameters:(NSString *)jsonParameters {
    NSLog(@"executeCommand className: %@, methodName: %@, jsonParameters: %@", className, methodName, jsonParameters);
}

@end
