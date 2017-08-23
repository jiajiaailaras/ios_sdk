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
#import "MKBlockingQueue.h"
#import "ATLControlChannel.h"

static const char * const kInternalQueueName     = "com.adjust.TestLibrary";

@interface ATLTestLibrary()

@property (nonatomic, weak, nullable) NSObject<AdjustCommandDelegate> *commandDelegate;
@property (nonatomic, strong) dispatch_queue_t internalQueue;
@property (nonatomic, copy) NSString *currentBasePath;
@property (nonatomic, strong) MKBlockingQueue *waitControlQueue;
@property (nonatomic, strong) ATLControlChannel *controlChannel;

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
    [self resetTestLibrary];

    [ATLUtil launchInQueue:self.internalQueue
                 selfInject:self
                      block:^(ATLTestLibrary * selfI) {
                          [selfI sendTestSessionI:clientSdk];
                      }];
    
}

- (void)resetTestLibrary {
    [self teardown];

    [self initTest];
}

- (void)teardown {
    if (self.internalQueue != nil) {
        [ATLUtil debug:@"cancel test library thread queue"];
        dispatch_cancel(self.internalQueue);
    }
    self.internalQueue = nil;

    [self clearTest];
}

- (void)clearTest {
    if (self.controlChannel != nil) {
        [self.controlChannel teardown];
    }
    self.waitControlQueue = nil;
    self.controlChannel = nil;
}

- (void)resetTest {
    [self clearTest];

    [self initTest];
}

- (void)initTest {
    self.waitControlQueue = [[MKBlockingQueue alloc] init];
    self.internalQueue = dispatch_queue_create(kInternalQueueName, DISPATCH_QUEUE_SERIAL);
}

- (void)sendTestSessionI:(NSString *)clientSdk {
    ATLHttpRequest * requestData = [[ATLHttpRequest alloc] init];
    requestData.headerFields = @{@"Client-SDK": clientSdk};
    requestData.path = @"/init_session";
    
    [ATLUtilNetworking sendPostRequest:requestData
                        responseHandler:^(ATLHttpResponse *httpResponse) {
                            [self readHeaders:httpResponse];
                        }];
}

- (void)readHeaders:(ATLHttpResponse *)httpResponse {
    [ATLUtil launchInQueue:self.internalQueue
                selfInject:self
                     block:^(ATLTestLibrary * selfI) {
                         [selfI readHeadersI:httpResponse];
                     }];
}
- (void)readHeadersI:(ATLHttpResponse *)httpResponse {
    [ATLUtil debug:@"readHeadersI"];
    return;

    if (httpResponse.headerFields == nil) {
        [ATLUtil debug:@"headers null"];
        return;
    }
    
    if ([httpResponse.headerFields objectForKey:TEST_SESSION_END_HEADER]) {
        [self teardown];
        [ATLUtil debug:@"TestSessionEnd received"];
        return;
    }
    if ([httpResponse.headerFields objectForKey:BASE_PATH_HEADER]) {
        self.currentBasePath = httpResponse.headerFields[BASE_PATH_HEADER][0];
    }
    if ([httpResponse.headerFields objectForKey:TEST_SCRIPT_HEADER]) {
        NSString * currentTest = httpResponse.headerFields[TEST_SCRIPT_HEADER][0];
        [ATLUtil debug:@"current test is %@", currentTest];

        [self resetTest];
        // TODO add control channel
        /*
         if (controlChannel != null) {
         controlChannel.teardown();
         }
         controlChannel = new ControlChannel(this);
         */
        // List<TestCommand> testCommands = Arrays.asList(gson.fromJson(httpResponse.response, TestCommand[].class));
        [self execTestCommandsI:httpResponse.jsonResponse];
    }
}

- (void)execTestCommandsI:(NSDictionary *)jsonResponse {
    [ATLUtil debug:@"execTestCommands"];
}

@end
