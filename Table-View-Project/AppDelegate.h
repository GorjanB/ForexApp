//
//  AppDelegate.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 1/31/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, readonly) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end

