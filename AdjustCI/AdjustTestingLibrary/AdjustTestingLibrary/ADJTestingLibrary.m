//
//  AdjustTestingLibrary.m
//  AdjustTestingLibrary
//
//  Created by Pedro on 18.04.17.
//  Copyright © 2017 adjust. All rights reserved.
//

#import "ADJTestingLibrary.h"

static NSString * const kLogTag = @"AdjustTestLibrary";

@interface ADJTestingLibrary()

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, weak, nullable) NSObject<AdjustCommandDelegate> *commandDelegate;

@end

@implementation ADJTestingLibrary

- (id)initWithBaseUrl:(NSString *)baseUrl
   andCommandDelegate:(NSObject<AdjustCommandDelegate> *)commandDelegate;
{
    self = [super init];
    if (self == nil) return nil;

    self.baseUrl = baseUrl;
    self.commandDelegate = commandDelegate;
    
    return self;
}

- (void)initTestSession:(NSString *)clientSdk {
    
}

+ (void)debug:(NSString *)format, ...{
    va_list parameters; va_start(parameters, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:parameters];
    va_end(parameters);
    NSArray *lines = [string componentsSeparatedByString:@"\n"];
    for (NSString *line in lines) {
        NSLog(@"\t[%@]: %@", kLogTag, line);
    }
}
@end
