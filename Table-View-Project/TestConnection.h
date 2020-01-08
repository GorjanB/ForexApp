//
//  TestConnection.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/13/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestConnection : NSObject

+ (void) testInternetConnection:(UIViewController *)controller;
+ (void) testAPIConnection:(NSString *)urlString controller:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
