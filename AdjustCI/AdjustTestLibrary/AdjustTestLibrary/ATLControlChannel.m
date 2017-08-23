//
//  ATLControlChannel.m
//  AdjustTestLibrary
//
//  Created by Pedro on 23.08.17.
//  Copyright © 2017 adjust. All rights reserved.
//

#import "ATLControlChannel.h"

static const char * const kInternalQueueName     = "com.adjust.ControlChannel";

@interface ATLControlChannel()

@property (nonatomic, strong) dispatch_queue_t internalQueue;
@property (nonatomic, strong) ATLTestLibrary * testLibrary;
@property (nonatomic, assign) BOOL closed;
@end

@implementation ATLControlChannel

- (id)initWithTestLibrary:(ATLTestLibrary *)testLibrary {
    self = [super init];
    if (self == nil) return nil;

    self.testLibrary = testLibrary;
    self.internalQueue = dispatch_queue_create(kInternalQueueName, DISPATCH_QUEUE_SERIAL);
    self.closed = NO;

    return self;
}

- (void)teardown {
    if (self.internalQueue != nil) {
        [ATLUtil debug:@"cancel control channel thread queue"];
        dispatch_cancel(self.internalQueue);
    }
    self.internalQueue = nil;
    self.testLibrary = nil;
    self.closed = YES;
}

@end
