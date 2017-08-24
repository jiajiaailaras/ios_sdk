//
//  ViewController.m
//  AdjustTestApp
//
//  Created by Pedro on 23.08.17.
//  Copyright © 2017 adjust. All rights reserved.
//

#import "ViewController.h"
#import "Adjust.h"
#import "ATLTestLibrary.h"
#import "ATAAdjustCommandExecutor.h"

@interface ViewController ()
@property (nonatomic, strong) ATLTestLibrary * testLibrary;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    ATAAdjustCommandExecutor * adjustCommandExecutor = [[ATAAdjustCommandExecutor alloc] init];

    self.testLibrary = [ATLTestLibrary testLibraryWithBaseUrl:@"http://127.0.0.1:8080/" andCommandDelegate:adjustCommandExecutor];
    [self startTestSession];
}

- (void)startTestSession {
    [self.testLibrary startTestSession:@"ios4.12.0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
