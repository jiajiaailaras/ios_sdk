//
//  ATLUtil.m
//  AdjustTestLibrary
//
//  Created by Pedro on 18.04.17.
//  Copyright © 2017 adjust. All rights reserved.
//

#import "ATLUtil.h"

static NSString * const kLogTag = @"AdjustTestLibrary";

@implementation ATLUtil

+ (void)debug:(NSString *)format, ...{
    va_list parameters; va_start(parameters, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:parameters];
    va_end(parameters);
    NSArray *lines = [string componentsSeparatedByString:@"\n"];
    for (NSString *line in lines) {
        NSLog(@"\t[%@]: %@", kLogTag, line);
    }
}

+ (void)launchInQueue:(dispatch_queue_t)queue
           selfInject:(id)selfInject
                block:(selfInjectedBlock)block {
    __weak __typeof__(selfInject) weakSelf = selfInject;
    
    dispatch_async(queue, ^{
        __typeof__(selfInject) strongSelf = weakSelf;
        
        if (strongSelf == nil) {
            return;
        }
        
        block(strongSelf);
    });
}

+ (void)addOperationAfterLast:(NSOperationQueue *)operationQueue
                        block:(dispatch_block_t)block
{
    // https://stackoverflow.com/a/8113307/2393678
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    __weak __typeof__(NSBlockOperation *) weakOperation = operation;

    [operation addExecutionBlock:^{
        __typeof__(NSBlockOperation *) strongOperation = weakOperation;

        if (strongOperation == nil) {
            return;
        }

        if (strongOperation.cancelled) {
            return;
        }

        block();
    }];

    // https://stackoverflow.com/a/32701781/2393678
    NSOperation *lastOperation = operationQueue.operations.lastObject;
    if (lastOperation != nil) {
        [operation addDependency: lastOperation];
    }

    [operationQueue addOperation:operation];
}

+ (BOOL)isNull:(id)value {
    return value == nil || value == (id)[NSNull null];
}

+ (NSString *)adjTrim:(NSString *)value {
    return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
