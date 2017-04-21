//
//  AdjustTestLibrary.m
//  AdjustTestLibrary
//
//  Created by Pedro on 18.04.17.
//  Copyright © 2017 adjust. All rights reserved.
//

#import "ATLTestLibrary.h"
#import "ATLUtil.h"
#import "ATLUtilNetworking.h"
#import "ATLConstants.h"

static const char * const kInternalQueueName     = "com.adjust.TestLibrary";

@interface ATLTestLibrary()

@property (nonatomic, weak, nullable) NSObject<AdjustCommandDelegate> *commandDelegate;
@property (nonatomic, strong) dispatch_queue_t internalQueue;
@property (nonatomic, copy) NSString *currentBasePath;

@end

@implementation ATLTestLibrary

static NSURL * _baseUrl = nil;

+ (NSURL *)baseUrl {
    return _baseUrl;
}

- (id)initWithBaseUrl:(NSURL *)baseUrl
   andCommandDelegate:(NSObject<AdjustCommandDelegate> *)commandDelegate;
{
    self = [super init];
    if (self == nil) return nil;
    
    _baseUrl = baseUrl;
    self.commandDelegate = commandDelegate;
    
    return self;
}

- (void)initTestSession:(NSString *)clientSdk {
    self.internalQueue = dispatch_queue_create(kInternalQueueName, DISPATCH_QUEUE_SERIAL);
    [ATLUtil launchInQueue:self.internalQueue
                 selfInject:self
                      block:^(ATLTestLibrary * selfI) {
                          [selfI sendTestSessionI:clientSdk];
                      }];
    
}

- (void)sendTestSessionI:(NSString *)clientSdk {
    ATLHttpRequest * requestData = [[ATLHttpRequest alloc] init];
    requestData.headerFields = @{@"Client-SDK": clientSdk};
    requestData.path = @"/init_session";
    
    [ATLUtilNetworking sendPostRequest:requestData
                        responseHandler:^(ATLHttpResponse *httpResponse) {
                            [self readHeadersI:httpResponse];
                        }];
}

- (void)readHeadersI:(ATLHttpResponse *)httpResponse {
    if (httpResponse.headerFields == nil) {
        [ATLUtil debug:@"headers null"];
        return;
    }
    
    if ([httpResponse.headerFields objectForKey:TEST_SESSION_END_HEADER]) {
        // TODO add control channel
        /*
        if (controlChannel != null) {
            controlChannel.teardown();
        }
        controlChannel = null;
        debug("TestSessionEnd received");
         */
        return;
    }
    if ([httpResponse.headerFields objectForKey:BASE_PATH_HEADER]) {
        self.currentBasePath = httpResponse.headerFields[BASE_PATH_HEADER][0];
    }
    if ([httpResponse.headerFields objectForKey:TEST_SCRIPT_HEADER]) {
        NSString * currentTest = httpResponse.headerFields[TEST_SCRIPT_HEADER][0];
        [ATLUtil debug:@"current test is %@", currentTest];
        // TODO add control channel
        /*
         if (controlChannel != null) {
         controlChannel.teardown();
         }
         controlChannel = new ControlChannel(this);
         */
        // List<TestCommand> testCommands = Arrays.asList(gson.fromJson(httpResponse.response, TestCommand[].class));
        [self execTestCommandsI];
    }
}

- (void)execTestCommandsI {
}

@end
