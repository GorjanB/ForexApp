//
//  InternetConnection.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/13/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "InternetConnection.h"
#import "ReachabilityR.h"

@interface InternetConnection(){
    
    Reachability *internetReachable;
}

@end

@implementation InternetConnection

- (void)testInternetConnection{
    __weak typeof(self) weakSelf = self;
    internetReachable = [Reachability reachabilityWithHostName:@"www.google.com"];
    
    internetReachable.reachableBlock = ^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Internet is reachable");
        });
    };
    
    internetReachable.unreachableBlock = ^(Reachability *reach)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No internet connection" message:@"You need internet for Countries and Forex." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        [alert addAction:defaultAction];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"No internet connection");
            [weakSelf presentViewController:alert animated:YES completion:nil];
        });
    };
    
    [internetReachable startNotifier];
    
}

@end
