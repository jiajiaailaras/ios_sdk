//
//  AdjustTestingLibrary.h
//  AdjustTestingLibrary
//
//  Created by Pedro on 18.04.17.
//  Copyright © 2017 adjust. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AdjustCommandDelegate <NSObject>
@optional
- (void)executeCommand:(NSString *)className
            methodName:(NSString *)methodName
            parameters:(NSDictionary *)parameters;

- (void)executeCommand:(NSString *)className
            methodName:(NSString *)methodName
        jsonParameters:(NSString *)jsonParameters;
@end

@interface ADJTestingLibrary : NSObject

- (id)initWithBaseUrl:(NSString *)baseUrl
   andCommandDelegate:(NSObject<AdjustCommandDelegate> *)commandDelegate;

- (void)initTestSession:(NSString *)clientSdk;

@end
