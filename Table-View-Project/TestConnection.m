//
//  TestConnection.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/13/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "TestConnection.h"
#import <UIKit/UIKit.h>
#import "ReachabilityR.h"
#import <AFNetworking.h>

@interface TestConnection()
{
   // Reachability *internetReachable;
    
}

@end

@implementation TestConnection

+ (void) testInternetConnection:(UIViewController *)controller{
    //__weak typeof(self) weakSelf = self;
    Reachability *internetReachable = [Reachability reachabilityWithHostName:@"www.google.com"];
    
    internetReachable.reachableBlock = ^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Internet is reachable");
        });
    };
    
    internetReachable.unreachableBlock = ^(Reachability *reach)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No internet connection" message:@"There is a problem with your internet connection" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        [alert addAction:defaultAction];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"No internet connection");
            [controller presentViewController:alert animated:YES completion:nil];
        });
    };
    
    [internetReachable startNotifier];
}

+ (void) testAPIConnection:(NSString *)urlString controller:(UIViewController *)controller
{
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:urlString];
    NSString *urlStr = [NSString stringWithString:mutableString];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[error localizedDescription]);
        if(data != nil){
                NSLog(@"simna nesto! %lu",data.length);
            NSLog(@"%@",[response suggestedFilename]);
            if(![[response suggestedFilename] isEqualToString:@"all"] && ![[response suggestedFilename] isEqualToString:@"latest"]) {
                NSLog(@"Is not equal to all");
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Can't connect to the API server" message:@"The API server seems unresponsive." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
                    [alert addAction:defaultAction];
                    [controller presentViewController:alert animated:YES completion:nil];
                });
                
            }
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"No internet connection");
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Can't connect to the API server" message:@"The API server seems unresponsive." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
                [alert addAction:defaultAction];
                [controller presentViewController:alert animated:YES completion:nil];
            });
            
        }
    }]
     resume];
}
@end
